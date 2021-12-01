# Nginx webserver on AWS with a valid certificate

In this repository you will deploy a webserver with Terraform on AWS. This webserver should use your own SSL certificates for a secure connection to your website. 

Steps involved are: 
- Creating an EC2 instance with Ubuntu in a default VPC
- Creating a Security group that allows traffic over port 443 to the website
- Create a DNS record within AWS route 53 pointing to the public IP address of the webserver

There is a short [README.md](manual_notes/README.md) on how to do all this manually without Terraform. This is just to give you a better idea on the steps involved. Please use this only if you do not want to use Terraform. 

# Prerequisites

## SSL certificate
You need to have valid SSL certificates that can be used with the DNS name you will be using to contact the webserver.  
  
If you don't have valid SSL certificates you can create one for free using Let's Encrypt. This repository includes an instruction on how to do this. [See documentation](nginx_create_certificate/README.md) This documentation will use Vagrant to create a server that can be used to create the SSL certificates. If you have SSL certificates you can skip this manual.    

Your SSL certificates should be placed in the ```certificates``` folder

## AWS
We will be using AWS and use the environment of us-east-1. Make sure you have the following
- AWS account  
- AWS Key Pair used for connecting to the Ubuntu server  
- Install AWS cli [See documentation](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

## Install terraform  
See the following documentation [How to install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)


# How to

- Clone the repository to your local machine
```
git clone https://github.com/munnep/aws_nginx.git
```
- Go to the directory
```
cd aws_nginx
```
- copy your private key (AWS Key Pair) from AWS to the directory ```private_key```
- copy your SSL certificates to the directory ```certificates```. Note the filenames you should use. 
```
full_chain.pem
priv_key.pem
```
- change the values in the ```variables.tf``` to mach your environment
- Set your AWS credentials
```
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_SESSION_TOKEN=
```
- Terraform initialize
```
terraform init
```
- Terraform plan
```
terraform plan
```
- Terraform apply
```
terraform apply
```
- Terraform output should create 3 resources and show you the public ip address
```
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

instance_public_ip = "52.87.193.96"
website_url = "https://patrick.bg.hashicorp-success.com"
```
- You should be able to connect to the website_url with a secure https connection in your web browser


# Done
- [x] create EC2 instance with Public IP on it
- [x] add security group for ssh, ICMP (ping) and http/https
- [x] create fqdn dns entry on domain (use one available on r53)
- [x] get a valid ssl cert for dns entry
- [x] configure a nginx web
- [x] test certificate works - on a desktop browser padlock closes"

# To do 
