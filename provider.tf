terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.ac_key
  secret_key = var.sc_key
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh-key"
  public_key = file(var.pub_key_path)

  tags = {
    project = var.project
  }
}