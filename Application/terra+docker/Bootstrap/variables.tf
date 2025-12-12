variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "state_bucket_name" {
  type        = string
  description = "Globally unique S3 bucket name for Terraform remote state"
}

variable "lock_table_name" {
  type        = string
  description = "DynamoDB table name for Terraform state locking"
}

variable "tags" {
  type    = map(string)
  default = {}
}
