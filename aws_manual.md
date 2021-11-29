# AWS manual build

Steps to manually build the AWS environment

- create VPC
- create subnet
- create internet gateway
- attach internet gatway
- allocate elastic ip
- security group creation
- create an instance
- attach the elastic ip to the instance
- associate the elastic ip adress with the instance
- change the dns record to this elastic ip address
- create a route table with a route to the internet gateway
- associate the route table with the subnet
- copy the certifcates for the website to the host
```
scp -r patrick.bg.hashicorp-success.com ubuntu@patrick.bg.hashicorp-success.com:/tmp
```
- logon to the ubuntu host
```
ssh ubuntu@patrick.bg.hashicorp-success.com
```
- On the host
```
sudo apt-get update
sudo apt-get install -y nginx
sudo mkdir -p /etc/letsencrypt/live/patrick.bg.hashicorp-success.com/
sudo cp /tmp/patrick.bg.hashicorp-success.com/* /etc/letsencrypt/live/patrick.bg.hashicorp-success.com/
```
- edit the nginx file
```
# Default server configuration
server {
	listen 80 default_server;
	listen [::]:80 default_server;

	# SSL configuration
	#
	listen 443 ssl default_server;
	listen [::]:443 ssl default_server;

	ssl_certificate /etc/letsencrypt/live/patrick.bg.hashicorp-success.com/fullchain.pem; # managed by Certbot
	ssl_certificate_key /etc/letsencrypt/live/patrick.bg.hashicorp-success.com/privkey.pem; # managed by Certbot

	root /var/www/html;
	index index.html index.htm index.nginx-debian.html;
	server_name _;

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;
	}
}
```
- restart nginx
```
sudo service nginx restart
```