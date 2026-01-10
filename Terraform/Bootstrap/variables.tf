variable "region" {
  description = "AWS region to deploy bootstrap resources into."
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)."
  type        = string
}

variable "log_bucket_name" {
  description = "Name of the existing/desired S3 log bucket."
  type        = string
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket used for Terraform remote state."
  type        = string
}

variable "lock_table_name" {
  description = "Name of the DynamoDB table used for Terraform state locking."
  type        = string
}
