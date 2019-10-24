# main.tf

provider "aws" {
  # region     = "${var.aws_region}"
  region     = "us-east-1"
}

module "vpc_networking" {
  source = "../modules/networking/"
  vpc_name = "prod"
  vpc_cidr_block = "192.188.0.0/16"
  vpc_subnets = {
    public_subnet_1 = "192.188.11.0/24"
    public_subnet_2 = "192.188.12.0/24"
    private_subnet_1 = "192.188.21.0/24"
    private_subnet_2 = "192.188.22.0/24"
  }
  vpc_default_route = "0.0.0.0/0"
}

