resource "aws_instance" "web_server" {
  ami             = var.ima
  instance_type   = "t2.micro"
  key_name        = var.key_pair
  security_groups = [aws_security_group.web_server_sg.name]


  tags = {
    Name = var.instance_name
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    password    = ""
    private_key = file("private_key/${var.private_key}")
  }

  provisioner "file" {
    source      = "certificates"
    destination = "/tmp"
  }

  provisioner "file" {
    source      = "config"
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install nginx -y",
      "sudo mkdir -p /etc/letsencrypt/live/website/",
      "sudo cp /tmp/certificates/* /etc/letsencrypt/live/patrick.bg.hashicorp-success.com/",
      "sudo cp /tmp/config/default /etc/nginx/sites-enabled/default",
      "sudo service nginx restart"
    ]
  }
}


# resource "aws_network_interface_sg_attachment" "sg_attachment" {
#   security_group_id    = aws_security_group.web_server_sg.id
#   network_interface_id = aws_instance.web_server.primary_network_interface_id
# }

resource "aws_security_group" "web_server_sg" {
  name        = "web_server_sg"
  description = "web_server_sg"

  ingress {
    description = "https from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh from internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "icmp from internet"
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web_server_sg"
  }
}

resource "aws_route53_record" "www" {
  zone_id = var.route53_zone_id
  name    = var.route53_zone_dns
  type    = "A"
  ttl     = "300"
  records = [aws_instance.web_server.public_ip]
}