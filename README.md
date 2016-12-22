# AWS Blog Framework

Want to host a blog? What a secure and scalable way to do it?

Look no further than this repository!

## What are you providing?

* A blogging platform based on the Python Flask framework
* An Amazon RDS backend
* A secure hosting environment (host access is via a bastion host, web only
  access is via an Elastic Load Balancer)
* AWS Hosted DNS via Route 53
* Free SSL Certificates via "letsencrypt"

## What do I need to do?

* Clone this git repository:
  ```
  git clone <REPO>
  cd <REPO>
  ```
* Run the installer script
  ```
  bash ./installer.sh
  ```
* Update your DNS server records with the ones the script provides
* Browse to www.<yourdomain>.<yourtld> and start working on the site!
