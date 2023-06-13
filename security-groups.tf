resource "aws_security_group" "Ion_SG" {
  name   = "Ion_SG"
  vpc_id = aws_vpc.Ion_VPC.id
  dynamic "ingress" {
    for_each = ["22", "80", var.wport, "27017"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.vpc_all_ips]
    }
  }

  ingress {
    from_port   = -1
    protocol    = "icmp"
    to_port     = -1
    cidr_blocks = [var.vpc_all_ips]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [var.vpc_all_ips]
  }

  tags = {
    project = var.project
  }
}