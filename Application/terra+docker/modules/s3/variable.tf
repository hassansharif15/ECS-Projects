variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
}

variable "tags" {
  description = "Tags applied to bucket resources"
  type        = map(string)
  default     = {}
}

variable "enable_versioning" {
  description = "Enable S3 versioning (recommended for Terraform state)"
  type        = bool
  default     = true
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm (AES256 or aws:kms)"
  type        = string
  default     = "AES256"
}

variable "enable_lifecycle_rules" {
  description = "Enable lifecycle rules (e.g., expire noncurrent versions)"
  type        = bool
  default     = true
}

variable "noncurrent_version_expiration_days" {
  description = "Days to retain noncurrent (old) object versions"
  type        = number
  default     = 90
}
