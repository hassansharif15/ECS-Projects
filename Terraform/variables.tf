# Global


variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "tags" {
  type = map(string)
  default = {
    Project = "ecs-app"
    Env     = "dev"
  }
}

# VPC Variables


variable "vpc_name" {
  type    = string
  default = "main-vpc"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_azs" {
  type    = list(string)
  default = ["eu-west-2a", "eu-west-2b"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "private_subnet_azs" {
  type    = list(string)
  default = ["eu-west-2a", "eu-west-2b"]
}


# Security Groups


variable "alb_sg_name" {
  type    = string
  default = "alb-sg"
}

variable "ecs_sg_name" {
  type    = string
  default = "ecs-sg"
}


# IAM


variable "execution_role_name" {
  type    = string
  default = "ecsTaskExecutionRole"
}


# ALB


variable "alb_name" {
  type    = string
  default = "tm-app-alb"
}

variable "tg_name" {
  type    = string
  default = "tm-app-tg"
}

variable "health_check_path" {
  type    = string
  default = "/health"
}


# ECS


variable "cluster_name" {
  type    = string
  default = "threat_app"
}

variable "container_image" {
  type    = string
  default = "565561497782.dkr.ecr.eu-west-2.amazonaws.com/hassan614/ecs-app:v3"
}

variable "container_name" {
  type    = string
  default = "tm-app"
}

variable "container_port" {
  type    = number
  default = 80
}

variable "ecs_cpu" {
  type    = string
  default = "1024"
}

variable "ecs_memory" {
  type    = string
  default = "3072"
}

variable "desired_count" {
  type    = number
  default = 1
}


# DNS / Certificates


variable "domain_name" {
  type = string

}


variable "hosted_zone_id" {
  type = string

}
