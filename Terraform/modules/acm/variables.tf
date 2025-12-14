variable "domain_name" {
  description = "Primary domain name for the certificate (e.g. tm.example.com)"
  type        = string
}

variable "subject_alternative_names" {
  description = "Optional additional domains for the certificate"
  type        = list(string)
  default     = []
}

variable "hosted_zone_id" {
  description = "Route53 hosted zone ID where validation records will be created"
  type        = string
}

variable "validation_ttl" {
  description = "TTL for DNS validation records"
  type        = number
  default     = 60
}

variable "tags" {
  description = "Tags to apply to the certificate"
  type        = map(string)
  default     = {}
}
