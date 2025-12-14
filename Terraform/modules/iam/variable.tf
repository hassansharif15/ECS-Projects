variable "execution_role_name" {
  type    = string
  default = "ecsTaskExecutionRole"
}

variable "tags" {
  type    = map(string)
  default = {}
}
