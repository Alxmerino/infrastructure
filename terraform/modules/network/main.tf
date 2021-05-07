resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true

    tags = {
        Name: "${var.name}-vpc"
    }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
    vpc_id = aws_vpc.main.id

    tags = {
        "Name" = "${var.name}-ig"
    }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
    route_table_id = aws_vpc.main.main_route_table_id
}

# Public subnet to launch our load balancer
resource "aws_subnet" "pub_subnet" {
    count = length(var.availability_zones)

    availability_zone = element(var.availability_zones, count.index)
    cidr_block = cidrsubnet(var.cidr_block, 8, count.index * 4)
    map_public_ip_on_launch = true
    vpc_id = aws_vpc.main.id

    tags = {
        "Name" = format("${var.name}-subnet-%02d", count.index + 1)
    }
}

# Private subnet to launch our app into
resource "aws_subnet" "prv_subnet" {
    count = length(var.availability_zones)

    availability_zone = element(var.availability_zones, count.index)
    cidr_block = cidrsubnet(var.cidr_block, 8, (count.index + 8) * 4)
    vpc_id = aws_vpc.main.id

    tags = {
        "Name" = format("${var.name}-subnet-%02d", count.index + 1)
    }
}
