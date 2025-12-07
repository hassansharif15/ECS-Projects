module "vpc" {
  source = "./modules/vpc"
}


module "sg" {
  source = "./modules/sg"

  vpc_id = module.vpc.vpc_id

}

########################################
# Load Balancer + Target Group + Listener
########################################

resource "aws_lb" "app_alb" {
  name               = "tm-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  tags = {
    Name = "tm-app-alb"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name        = "tm-app-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main_vpc.id

  # /health is defined in your nginx.conf and returns 200
  health_check {
    path                = "/health"
    matcher             = "200-399"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "tm-app-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

########################################
# ECS Cluster
########################################

resource "aws_ecs_cluster" "app_cluster" {
  name = "threat_app"

  tags = {
    Name = "threat_app_cluster"
  }
}

resource "aws_ecs_cluster_capacity_providers" "app_cluster_providers" {
  cluster_name       = aws_ecs_cluster.app_cluster.name
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
    base              = 1
  }
}

########################################
# IAM: Task Execution Role (for ECS + ECR)
########################################

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_ecr_read" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

########################################
# ECS Task Definition
########################################

resource "aws_ecs_task_definition" "service" {
  family                   = "ecs-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"   # 1 vCPU
  memory                   = "3072"   # 3 GB
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "tm-app"
      image     = "565561497782.dkr.ecr.eu-west-2.amazonaws.com/hassan614/ecs-app:v3"
      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

########################################
# ECS Service
########################################

resource "aws_ecs_service" "app_service" {
  name            = "tm-app-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [
      aws_subnet.private_subnet_1.id,
      aws_subnet.private_subnet_2.id
    ]
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name   = "tm-app"
    container_port   = 80
  }

  depends_on = [
    aws_lb_listener.http,
    aws_ecs_cluster_capacity_providers.app_cluster_providers
  ]
}


