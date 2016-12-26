#!/bin/bash
if [ -z $TF_VAR_deploy_key ]; then
    echo "Please set \$TF_VAR_deploy_key to point to the SSH keypair you wish to use"
    exit 2
else
    if [ ! -e $TF_VAR_deploy_key ]; then
        echo "\$TF_VAR_deploy_key set but file does not exist\nCurrent Value: $TF_VAR_deploy_key"
        exit 2
    fi
fi
echo "Adding the Deploy Key to SSH Agent"
ssh-add $TF_VAR_deploy_key
echo "Setting up Terraform State File"
export TF_STATE_FILE=$(pwd)/terraform.tfstate
echo "Terraform State File set to $TF_STATE_FILE"
cd terraform
echo "Running Terraform"
terraform apply -state=$TF_STATE_FILE
TF_EXIT_CODE=$?
if [ "$TF_EXIT_CODE" -eq "0" ]; then
  echo "Waiting 30 seconds for AWS to settle down"
  sleep 30
  echo "Wiping existing hosts on the private subnet from your known hosts file to avoid key collisions"
  for a in $(grep private_ip $TF_STATE_FILE|cut -d ":" -f 2 | cut -d '"' -f 2); do 
    ssh-keygen -f "${HOME}/.ssh/known_hosts" -R $a; 
  done
  echo "Resuming..."
  TF_BASTION=$(terraform output -state=$TF_STATE_FILE nat.ip)
  cd ../ansible
  workon ansible2
  echo "Preparing to run Ansible"
  echo -e "\n========\nPlease accept the Server Key for $TF_BASTION\n============\n"
  ssh -o StrictHostKeyChecking=no ec2-user@$TF_BASTION "echo 'Thank you for accepting the host key'"
  echo "Setting Ansible Variables"
  CONSUL_WEB_URL=$(terraform output -state=$TF_STATE_FILE consul_elb)
  KIBANA_WEB_URL=$(terraform output -state=$TF_STATE_FILE kibana_elb)
  SITE_WEB_URL=$(terraform output -state=$TF_STATE_FILE web_elb)
  VPC_CIDR=$(terraform output -state=$TF_STATE_FILE vpc_subnet)
  echo "Getting the DNS Servers for your VPC"
  VPC_IP=$(echo ${VPC_CIDR} | cut -d '/' -f 1)
  ipoct1=$(echo ${VPC_IP} | tr "." " " | awk '{ print $1 }')
  ipoct2=$(echo ${VPC_IP} | tr "." " " | awk '{ print $2 }')
  ipoct3=$(echo ${VPC_IP} | tr "." " " | awk '{ print $3 }')
  ipoct4=$(echo ${VPC_IP} | tr "." " " | awk '{ print $4 }')
  VPC_DNS="$ipoct1.$ipoct2.$ipoct3.2"
  cat > ansible_extra_vars.json <<- EOM
  {
    "consul_web_url": "$CONSUL_WEB_URL", 
    "kibana_web_url": "$KIBANA_WEB_URL", 
    "site_web_url": "$SITE_WEB_URL", 
    "deploy_private_ssh_key": "$TF_VAR_deploy_key",
    "deploy_public_ssh_key": "$TF_VAR_deploy_key.pub",
    "vpc_cidr": "$VPC_CIDR", 
    "aws_access_key": "$TF_VAR_access_key", 
    "aws_secret_key": "$TF_VAR_secret_key", 
    "vpc_dns_server": "$VPC_DNS"
  }
EOM
  echo "Running Ansible"
  ansible-playbook -i inventory/ plays/launch.yml --extra-vars "@ansible_extra_vars.json"
  echo "Setup Complete"
  cat <<-EOM "You can access your new system at the following URLs:
  
  Consul: http://$CONSUL_WEB_URL
  Kibana: http://$KIBANA_WEB_URL
  Website: http://$SITE_WEB_URL

  Have Fun! :)"
EOM
  exit 0
else
  echo "Terraform Failed to complete. Please review the logs and re-run"
  exit 2
fi
