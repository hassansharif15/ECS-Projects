variable "vpc_id" {
  type = string
}

variable "alb_sg_name" {
  type    = string
  default = "alb-sg"
}

variable "ecs_sg_name" {
  type    = string
  default = "ecs-sg"
}

variable "tags" {
  type    = map(string)
  default = {}
}

