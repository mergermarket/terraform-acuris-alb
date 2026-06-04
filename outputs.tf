output "alb_dns_name" {
  value = aws_alb.alb.dns_name
}

output "alb_listener_arn" {
  value = aws_alb_listener.https.arn
}

output "alb_arn" {
  value = aws_alb.alb.arn
}

output "alb_zone_id" {
  value = aws_alb.alb.zone_id
}

output "alb_sg_name" {
  value = aws_security_group.default.name
}
