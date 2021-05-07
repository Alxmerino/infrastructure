variable "name" {
    description = "Name of this module"
}

variable "app_pub_subnet_id" {
    description = "The id of the public subnet"
}

variable "app_pub_subnet_ids" {
    description = "The ids of the public subnet"
}

variable "app_vpc_id" {
    description = "The id of the VPC to use"
}

variable "app_cidr_blocks" {
    description = "The CIDR blocks specified on the VPC"
}

variable "app_lb_sg_id" {
    description = "The Security Group for the ELB"
}

variable "app_ec2_sg_id" {
    description = "The Security Group for the ELB"
}

variable "app_env" {
    description = "The Application Environment"
}
