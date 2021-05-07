resource "aws_lb" "app_lb" {
    name = "${var.name}-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [var.app_lb_sg_id]
    subnets = var.app_pub_subnet_id

    // No logs yet, maybe cloudwatch
    //  access_logs {
    //    bucket  = aws_s3_bucket.lb_logs.bucket
    //    prefix  = "test-lb"
    //    enabled = true
    //  }

    tags = {
        Environment = "${var.name}-${var.app_env}"
    }
}

resource "aws_lb_target_group" "app_lb_tg" {
    name = "${var.name}-lb-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.app_vpc_id
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.app_lb_tg.arn
    type             = "forward"
  }
}

resource "aws_launch_configuration" "app_launch_config" {
    name_prefix = "launch-config-${var.name}-"
    // @todo: Should this be a variable or use from `data aws_ami`?
    image_id = "ami-0d5eff06f840b45e9"
    instance_type = "t2.micro"
    security_groups = [var.app_ec2_sg_id]
    user_data = <<-EOF
                  #!/bin/bash
                  sudo su
                  yum -y install httpd
                  echo "<h1> My Instance! from $(hostname -f)</h1>" >> /var/www/html/index.html
                  sudo systemctl enable httpd
                  sudo systemctl start httpd
                  EOF

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "app_asg" {
    name = "${var.name}-asg"
    max_size = 2
    min_size = 1
    health_check_grace_period = 300
    health_check_type = "ELB"
    desired_capacity = 2
    force_delete = true
    vpc_zone_identifier = var.app_pub_subnet_ids
    launch_configuration = aws_launch_configuration.app_launch_config.id

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_attachment" "app_asg_attachment" {
    autoscaling_group_name = aws_autoscaling_group.app_asg.name
    alb_target_group_arn = aws_lb_target_group.app_lb_tg.arn
}
