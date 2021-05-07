resource "aws_security_group" "lb_sg" {
    name = "${var.name}-lb-sg"
    description = "Allow TLS inbound traffic"
    vpc_id = var.app_vpc_id

    ingress {
        description = "Allow HTTP traffic"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        "Name" = "${var.name}-lb-sg"
    }
}

resource "aws_security_group" "ec2_sg" {
    name = "${var.name}-ec2-sg"
    description = "Allow inbound/outbound traffic from the ELB"
    vpc_id = var.app_vpc_id

    ingress {
        from_port = 80
        protocol = "tcp"
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
        //        cidr_blocks = [var.app_cidr_blocks]
    }
    egress {
        from_port = 0
        protocol = "-1"
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        "Name" = "${var.name}-ec2-sg"
    }
}
