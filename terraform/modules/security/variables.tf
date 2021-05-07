variable "name" {
    description = "Name of this module"
}

variable "app_vpc_id" {
    description = "The id of the VPC to use"
}

variable "app_cidr_blocks" {
    description = "The CIDR blocks specified on the VPC"
}
