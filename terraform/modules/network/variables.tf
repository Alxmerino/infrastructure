variable "name" {
    description = "Name of this module"
}

variable "availability_zones" {
  description = "Zones we want the network to be available in"
  type        = list(string)
}

variable "cidr_block" {
    type = string
    description = "VPC cidr block. Example: 10.10.0.0/16"
}

//
//variable "trusted_ssh_ips" {
//  description = "IP addresses allowed to SSH in"
//  type        = list
//}
