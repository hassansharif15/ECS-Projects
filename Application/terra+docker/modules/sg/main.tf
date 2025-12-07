# modules/sg/main.tf

# ALB SG – internet on 80
resource "aws_security_group" "alb_sg" {
  name        = var.alb_sg_name
  description = "Allow HTTP from the internet"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.alb_http_port
    to_port     = var.alb_http_port
    protocol    = "tcp"
    cidr_blocks = [var.alb_ingress_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.alb_sg_name
  }
}

# ECS SG – only ALB → tasks on port 80
resource "aws_security_group" "ecs_sg" {
  name        = var.ecs_sg_name
  description = "Allow traffic from ALB to ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.ecs_http_port
    to_port         = var.ecs_http_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.ecs_sg_name
  }
}
