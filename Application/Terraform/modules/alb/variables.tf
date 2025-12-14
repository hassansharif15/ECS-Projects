variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "alb_sg_id" {
  type = string
}

# ALB settings
variable "alb_name" {
  type    = string
  default = "tm-app-alb"
}

variable "internal" {
  type    = bool
  default = false
}

variable "load_balancer_type" {
  type    = string
  default = "application"
}

# Target group settings
variable "tg_name" {
  type    = string
  default = "tm-app-tg"
}

variable "tg_port" {
  type    = number
  default = 80
}

variable "tg_protocol" {
  type    = string
  default = "HTTP"
}

variable "target_type" {
  type    = string
  default = "ip"
}

# Health check settings
variable "health_check_path" {
  type    = string
  default = "/health"
}

variable "matcher" {
  type    = string
  default = "200-399"
}

variable "healthy_threshold" {
  type    = number
  default = 2
}

variable "unhealthy_threshold" {
  type    = number
  default = 2
}

variable "health_check_interval" {
  type    = number
  default = 30
}

variable "health_check_timeout" {
  type    = number
  default = 5
}

# Listener settings
variable "listener_port" {
  type    = number
  default = 80
}

variable "listener_protocol" {
  type    = string
  default = "HTTP"
}

variable "default_action_type" {
  type    = string
  default = "forward"
}

variable "certificate_arn" {
  type    = string
  default = ""
}

# Tags
variable "tags" {
  type    = map(string)
  default = {}
}
