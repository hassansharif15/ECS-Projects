output "certificate_arn" {
  description = "ARN of the validated ACM certificate"
  value       = aws_acm_certificate_validation.this.certificate_arn
}

output "domain_name" {
  description = "Primary domain name for this certificate"
  value       = aws_acm_certificate.this.domain_name
}

output "validation_record_fqdns" {
  description = "FQDNs of the Route53 validation records"
  value       = [for rec in aws_route53_record.validation : rec.fqdn]
}
