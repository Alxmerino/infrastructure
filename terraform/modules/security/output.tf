output "app_lb_sg_id" {
    value = aws_security_group.lb_sg.id
}

output "app_ec2_sg_id" {
    value = aws_security_group.ec2_sg.id
}
