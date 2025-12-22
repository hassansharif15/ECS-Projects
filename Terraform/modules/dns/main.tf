# Route53 Alias Record -> ALB


resource "aws_route53_record" "alias" {
  zone_id = var.hosted_zone_id
  name    = var.record_name 
  type    = var.record_type 

  alias {
    name                   = var.alias_name    # ALB DNS name
    zone_id                = var.alias_zone_id # ALB zone ID
    evaluate_target_health = var.evaluate_target_health
  }
}
