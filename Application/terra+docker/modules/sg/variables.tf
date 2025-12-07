# modules/sg/variables.tf

# VPC to attach the security groups to
variable "vpc_id" {
  type        = string
  description = "ID of the VPC where security groups will be created"
}

# ALB SG settings
variable "alb_sg_name" {
  type        = string
  description = "Name/tag for the ALB security group"
  default     = "alb-sg"
}

variable "alb_http_port" {
  type        = number
  description = "HTTP port for ALB"
  default     = 80
}

variable "alb_ingress_cidr" {
  type        = string
  description = "CIDR allowed to access the ALB"
  default     = "0.0.0.0/0"
}

# ECS SG settings
variable "ecs_sg_name" {
  type        = string
  description = "Name/tag for the ECS security group"
  default     = "ecs-sg"
}

variable "ecs_http_port" {
  type        = number
  description = "HTTP port on ECS tasks"
  default     = 80
}
