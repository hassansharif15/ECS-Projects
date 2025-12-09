resource "aws_lb" "app_alb" {
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids

  tags = merge(var.tags, {
    Name = var.alb_name
  })
}

resource "aws_lb_target_group" "app_tg" {
  name        = var.tg_name
  port        = var.tg_port
  protocol    = var.tg_protocol
  target_type = var.target_type
  vpc_id      = var.vpc_id

  health_check {
    path                = var.health_check_path
    matcher             = var.matcher
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
  }

  tags = merge(var.tags, {
    Name = var.tg_name
  })
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = var.default_action_type
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
