variable "aws_profile" {
    description = "AWS profile to use when provisioning the app. This is set in the ~/.aws directory"
}

variable "aws_region" {
    description = "AWS Region to place your app in"
    default = "us-east-1"
}

variable "name" {
    description = "The name of the app"
}
