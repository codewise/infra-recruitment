locals {
  subnets = ["subnet-1239213"]
  ami_id = "ami-1238201238"
  security_group_id = "sg-129321231"
  instance_type = "t3.large"
  vpc_id = "vpc-1293b12u2"
}

resource "aws_spot_fleet_request" "fleet-request" {
  iam_fleet_role      = "arn:aws:iam::085711051953:role/aws-ec2-spot-fleet-tagging-role"
  target_capacity     = 1
  valid_until         = "2023-07-13T00:00:00Z"
  allocation_strategy = "lowestPrice"

  target_group_arns = [aws_lb_target_group.rdp-lb-target-group.arn]

  launch_specification {
      instance_type          = local.instance_type
      ami                    = local.ami_id
      subnet_id              = local.subnets[0]
      vpc_security_group_ids = [local.security_group_id]
  }
}

resource "aws_lb" "rdp-lb" {
  name               = "am-rdp-private-lb"
  internal           = true
  load_balancer_type = "network"
  subnets            = local.subnets

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "rdp-lb-listener" {
  load_balancer_arn = aws_lb.rdp-lb.arn

  port     = 3389
  protocol = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rdp-lb-target-group.arn
  }
}

resource "aws_lb_target_group" "rdp-lb-target-group" {
  name     = "am-rdp-priv-3389"
  port     = 3389
  protocol = "TCP"
  vpc_id   = local.vpc_id

  health_check {
    protocol            = "TCP"
    port                = 3389
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}