# AWS Blog Framework

Want to host a blog? What a secure and scalable way to do it?

Look no further than this repository!

## What are you providing?

* A blogging platform based on https://github.com/proffalken/flask-blog
* An Amazon RDS backend
* A secure hosting environment (host access is via a bastion host, web only
  access is via an Elastic Load Balancer)
* AWS Hosted DNS via Route 53
* Free SSL Certificates via "letsencrypt"
* A centralised logging cluster based on ELK and Consul based on the work at
  https://doics.co/2015/05/18/increase-your-elk-herd-with-consul-io/

## What do I need to do?

* Clone this git repository:

  ```
  git clone https://github.com/proffalken/aws-blog-framework

  cd aws-blog-framework
  ```
* Run the installer script

  ```
  bash ./installer.sh
  ```
* Update your DNS server records with the ones the script provides
* Browse to www.yourdomain.yourtld and start working on the site!
