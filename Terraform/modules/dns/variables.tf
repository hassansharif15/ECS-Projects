variable "hosted_zone_id" {
  description = "Route53 hosted zone ID where the record will be created"
  type        = string
}

variable "record_name" {
  description = "DNS name for the record (e.g. app.example.com)"
  type        = string
}

variable "record_type" {
  description = "DNS record type"
  type        = string
  default     = "A"
}

variable "alias_name" {
  description = "Alias target DNS name (e.g. ALB DNS name)"
  type        = string
}

variable "alias_zone_id" {
  description = "Alias target hosted zone ID (e.g. ALB zone ID)"
  type        = string
}

variable "evaluate_target_health" {
  description = "Whether to evaluate target health for the alias"
  type        = bool
  default     = false
}
