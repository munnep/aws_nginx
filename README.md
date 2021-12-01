# Nginx webserver on AWS with a valid certificate

This README describes how to create a webserver with SSL certificates using terraform in AWS

# Prerequisites

AWS account  
AWS key pair   
SSL certificates for your website. Example on how to create them for free. [See documentation](nginx_create_certificate/README.md)   

# How to

## Use the Test Kitchen plugin
- Clone the repository to your local machine
```
git clone https://github.com/munnep/aws_nginx.git
```
- Go to the directory
```
cd aws_nginx
```
- copy your private key from AWS to the directory ```private_key```
- copy your SSL certificates to the directory ```certificates```
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
```


# to do 

- [x] create EC2 instance with Public IP on it
- [x] add security group for ssh, ICMP (ping) and http/https
- [x] create fqdn dns entry on domain (use one available on r53)
- [x] get a valid ssl cert for dns entry
- [x] configure a nginx web
- [x] test certificate works - on a desktop browser padlock closes"