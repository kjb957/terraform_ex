# main.tf

provider "aws" {
  # region     = "${var.aws_region}"
  region     = "us-east-1"
}

module "vpc_networking" {
  source = "../modules/networking/"
  vpc_name = "staging"
  vpc_cidr_block = "192.178.0.0/16"
  vpc_subnets = {
    public_subnet_1 = "192.178.11.0/24"
    public_subnet_2 = "192.178.12.0/24"
    private_subnet_1 = "192.178.21.0/24"
    private_subnet_2 = "192.178.22.0/24"
  }
  vpc_default_route = "0.0.0.0/0"
  my_ip_address = "71.245.226.55/32"
}


module "vpc_jumpbox" {
  source = "../modules/jumpbox/"
  vpc_name = "staging"
  ami_id = "ami-00eb20669e0990cb4"
  ec2_instance_type = "t2.micro"
  ec2_key = "my_default_key_pair"
  ec2_subnet_id = module.vpc_networking.public_subnet_1
  ec2_sg_id = module.vpc_networking.public_jumbox_sg_id
}