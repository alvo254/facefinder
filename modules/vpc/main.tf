resource "aws_vpc" "facefinder" {
  instance_tenancy = "default"
  enable_dns_hostnames = true
  cidr_block = var.vpc_cidr
  assign_generated_ipv6_cidr_block = true
  
  tags = {
    Name = "${var.project}-${var.env}-vpc"
  }
}

data "aws_availability_zones" "available_zones" {}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.facefinder.id
    cidr_block = var.public_subnet
    map_public_ip_on_launch = true
    availability_zone       = data.aws_availability_zones.available_zones.names[0]  //this is indexing


    ipv6_cidr_block = "${cidrsubnet(aws_vpc.facefinder.ipv6_cidr_block, 8, 1)}"
    assign_ipv6_address_on_creation = true

    tags = {
        Name = "${var.project}-${var.env}-dual-stack"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.facefinder.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    route {
        ipv6_cidr_block = "::/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    tags = {
        Name = "${var.project}-${var.env}-public-rt"
    }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.facefinder.id

  tags = {
    Name = "${var.project}-${var.env}-igw"
  }
}

resource "aws_route_table_association" "public_subnet_rt_association" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}
