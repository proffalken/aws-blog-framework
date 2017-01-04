variable "access_key" {
  description = "AWS access key"
}

variable "secret_key" {
  description = "AWS secret access key"
}

variable "region"     {
  description = "AWS region to host your network"
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.235.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.235.0.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  default     = "10.235.1.0/24"
}

variable "mysql-az1_subnet_cidr" {
  description = "CIDR for DB AZ1 subnet"
  default     = "10.235.2.0/24"
}

variable "mysql-az2_subnet_cidr" {
  description = "CIDR for DB AZ2 subnet"
  default     = "10.235.3.0/24"
}

variable "deploy_key" {
  description = "The SSH Key to use for deployments"
}

/* CentOS 7 amis by region */
variable "centos_amis" {
  description = "Base AMI to launch the instances with"
  default = {
    eu-west-1 = "ami-7abd0209"
    us-east-1 = "ami-61bbf104"
  }
}

variable "dns_domain" {
  description = "The DNS domain to use for the new site"
  default = "flask-blog.co.uk"
}
