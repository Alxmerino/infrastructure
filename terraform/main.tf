terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.2"
        }
    }
}

provider "aws" {
    profile = var.aws_profile
    region = var.aws_region
}

module "network" {
    source = "./modules/network"

    name = var.name
    cidr_block = "172.16.0.0/16"
    availability_zones = ["${var.aws_region}a", "${var.aws_region}c"]
}

module "security" {
    source = "./modules/security"

    name = var.name
    app_vpc_id = module.network.app_vpc_id
    app_cidr_blocks = module.network.app_cidr_blocks

}

module "web" {
    source = "./modules/web"

    name = var.name
    app_cidr_blocks = module.network.app_cidr_blocks
    app_ec2_sg_id = module.security.app_ec2_sg_id
    app_env = "staging"
    app_lb_sg_id = module.security.app_lb_sg_id
    app_pub_subnet_id = module.network.app_pub_subnet_id
    app_pub_subnet_ids = module.network.app_pub_subnet_ids
    app_vpc_id = module.network.app_vpc_id
}


// @TODO
// [ ] clean up
// [ ] add more health checks
// [ ] add logs
// [ ] add staging/prod tfvars?
// [ ] move ASG to private subnet
// [ ] Launch laravel app
