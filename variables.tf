variable "instance_name" {
  default = "patrick-web-server"
}

variable "ima" {
  default = "ami-083654bd07b5da81d"
}

variable "key_pair" {
  default = "patrick-key-pair"
}

variable "route53_zone_id" {
  default = "Z10QHT9XL7XFZU"
}

variable "route53_zone_dns" {
  default = "patrick.bg.hashicorp-success.com"
}

variable "private_key" {
  default = "patrick-key-pair.pem"
}

