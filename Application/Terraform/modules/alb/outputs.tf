output "alb_arn" {
  value = aws_lb.app_alb.arn
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}
output "alb_zone_id" {
  value = aws_lb.app_alb.zone_id
}
output "target_group_arn" {
  value = aws_lb_target_group.app_tg.arn
}

output "https_listener_arn" {
  value = aws_lb_listener.https.arn
}