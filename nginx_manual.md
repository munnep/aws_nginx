# NGINX

We create a valid certificate we can use in our environment

# steps

- in AWS create a valid DNS record in route53
```
patrick.bg.hashicorp-success.com	A	Simple	-	
192.168.56.33
```
- test it
```
nslookup patrick.bg.hashicorp-success.com

Server:		192.168.0.1
Address:	192.168.0.1#53

Non-authoritative answer:
Name:	patrick.bg.hashicorp-success.com
Address: 192.168.56.33
```

- create a vagra

