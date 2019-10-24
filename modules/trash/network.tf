#network.tf

############################################################################

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

############################################################################
resource "aws_vpc" "infrastructure_vpc" {
  cidr_block = "${var.vpc_cidr_block}"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.vpc_name}-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = "${aws_vpc.infrastructure_vpc.id}"
  cidr_block = "${var.vpc_subnets["public_subnet_1"]}"
  map_public_ip_on_launch = "true"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags = {
    Name = "${var.vpc_name}-public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = "${aws_vpc.infrastructure_vpc.id}"
  cidr_block = "${var.vpc_subnets["public_subnet_2"]}"
  map_public_ip_on_launch = "true"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags = {
    Name = "${var.vpc_name}-public_subnet_2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = "${aws_vpc.infrastructure_vpc.id}"
  cidr_block = "${var.vpc_subnets["private_subnet_1"]}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags = {
    Name = "${var.vpc_name}-private_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = "${aws_vpc.infrastructure_vpc.id}"
  cidr_block = "${var.vpc_subnets["private_subnet_2"]}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags = {
    Name = "${var.vpc_name}-private_subnet_2"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.infrastructure_vpc.id}"

  tags = {
    Name = "${var.vpc_name}-internet_gateway"
  }
}

############################################################################
resource "aws_route_table" "default_public_route" {
  vpc_id = "${aws_vpc.infrastructure_vpc.id}"

  route {
    cidr_block = "${var.vpc_default_route}"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }

  tags = {
    Name = "${var.vpc_name}-default_public_route"
  }
}

resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = "${aws_subnet.public_subnet_1.id}"
  route_table_id = "${aws_route_table.default_public_route.id}"
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = "${aws_subnet.public_subnet_2.id}"
  route_table_id = "${aws_route_table.default_public_route.id}"
}


############################################################################