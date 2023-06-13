variable "zone" {
  type    = string
  default = "eu-central-1a"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "project" {
  type    = string
  default = "ION"
}

variable "instance" {
  type    = string
  default = "t2.micro"
}

variable "pub_key_path" {
  type    = string
  default = "ssh/aws_key.pub"
}

variable "prv_key_path" {
  type    = string
  default = "ssh/aws_key"
}

variable "db_connection_src" {
  type    = string
  default = "connection/db.js"
}
variable "db_connection_dst" {
  type    = string
  default = "/home/ubuntu/db.js"
}

variable "docker_compose_src" {
  type    = string
  default = "docker/docker-compose-stack.yaml"
}
variable "docker_compose_dst" {
  type    = string
  default = "/home/ubuntu/docker-compose-stack.yaml"
}


variable "vpc_range" {
  type    = string
  default = "10.100.0.0/16"
}

variable "vpc-public_subnet_range" {
  type    = string
  default = "10.100.50.0/24"
}

variable "vpc-private_subnet_range" {
  type    = string
  default = "10.100.100.0/24"
}

variable "vpc_all_ips" {
  type    = string
  default = "0.0.0.0/0"
}

# ENV

variable "wport" {
  type    = string
  default = "5000"
}

variable "sip" {
  type    = string
  default = "`curl http://ident.me`"
}