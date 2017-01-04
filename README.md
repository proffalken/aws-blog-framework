# AWS Blog Framework

Want to host a blog? What a secure and scalable way to do it?

Look no further than this repository!

## What are you providing?

* A blogging platform based on https://github.com/proffalken/flask-blog
* An Amazon RDS backend
* A secure hosting environment (host access is via a bastion host, web only
  access is via an Elastic Load Balancer)
* AWS Hosted DNS via Route 53
* Free SSL Certificates via "letsencrypt" (TODO!)
* A centralised logging cluster based on ELK and Consul based on the work at
  https://doics.co/2015/05/18/increase-your-elk-herd-with-consul-io/

## What do I need to do?

* Install Terraform from terraform.io
* Clone this git repository:

  ```
  git clone https://github.com/proffalken/aws-blog-framework

  cd aws-blog-framework
  ```
* Create a file with your AWS Credentials and a couple of other settings as environment variables:
  ```
export AWS_ACCESS_KEY_ID=<ACCESS KEY ID>
export AWS_SECRET_ACCESS_KEY=<SECRET ACCESS KEY>
export TF_VAR_deploy_key=<PATH TO SSH KEY TO BE INSTALLED ON INSTANCES
export AWS_SSH_KEY_ID=<NAME OF KEY IN AWS>
export TF_VAR_access_key=$AWS_ACCESS_KEY_ID
export TF_VAR_secret_key=$AWS_SECRET_ACCESS_KEY
  ```
* Ensure that the above variables are set:
  ```
source <PATH TO ABOVE FILE>
```
* Create the Virtual Environment for Ansible and install the dependencies
```
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
```
* Run the installer script

  ```
  bash ./launch_infrastructure.sh
  ```
* Update your DNS server records with the ones the script provides
* Browse to www.yourdomain.yourtld and start working on the site!
