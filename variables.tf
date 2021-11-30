variable "instance_name" {
  default = "patrick-web-server"
  type    = string
}

variable "ima" {
  default = "ami-083654bd07b5da81d"
  type    = string
}

variable "key_pair" {
  default = "patrick-key-pair"
}