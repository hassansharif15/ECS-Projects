variable "table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
}

variable "billing_mode" {
  description = "Billing mode (PAY_PER_REQUEST recommended)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "enable_pitr" {
  description = "Enable Point-In-Time Recovery (recommended)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to the DynamoDB table"
  type        = map(string)
  default     = {}
}
