resource "aws_vpc" "Ion_VPC" {
  cidr_block                       = var.vpc_range
  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = false

  tags = {
    project = var.project
  }
}

resource "aws_subnet" "Ion_Public_Subnet" {
  vpc_id                  = aws_vpc.Ion_VPC.id
  cidr_block              = var.vpc-public_subnet_range
  map_public_ip_on_launch = true
  availability_zone       = var.zone
  tags = {
    project = var.project
  }
  depends_on = [aws_vpc.Ion_VPC]
}

resource "aws_internet_gateway" "Ion_IGW" {
  vpc_id = aws_vpc.Ion_VPC.id

  tags = {
    project = var.project
  }
}

resource "aws_route_table" "Ion_RT" {
  vpc_id = aws_vpc.Ion_VPC.id

  tags = {
    project = var.project
  }
}

resource "aws_route" "Ion_Route" {
  route_table_id         = aws_route_table.Ion_RT.id
  destination_cidr_block = var.vpc_all_ips
  gateway_id             = aws_internet_gateway.Ion_IGW.id
}

resource "aws_route_table_association" "Ion_Association" {
  subnet_id      = aws_subnet.Ion_Public_Subnet.id
  route_table_id = aws_route_table.Ion_RT.id
}