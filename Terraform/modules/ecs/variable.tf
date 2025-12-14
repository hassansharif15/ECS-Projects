variable "cluster_name" {
  type = string
}

variable "task_family" {
  type    = string
  default = "ecs-app"
}

variable "service_name" {
  type    = string
  default = "tm-app-service"
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_sg_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "image" {
  type = string
}

variable "cpu" {
  type    = string
  default = "1024"
}

variable "memory" {
  type    = string
  default = "3072"
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "container_name" {
  type    = string
  default = "tm-app"
}

variable "container_port" {
  type    = number
  default = 80
}

variable "tags" {
  type    = map(string)
  default = {}
}
