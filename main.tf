data "aws_acm_certificate" "cert" {
  count    = var.run_data ? 1 : 0
  domain   = var.certificate_domain_name
  statuses = ["ISSUED"]
  key_types = ["RSA_4096", "RSA_2048"]
}

resource "aws_alb" "alb" {
  name            = replace(replace(var.name, "/(.{0,32}).*/", "$1"), "/^-+|-+$/", "")
  internal        = var.internal
  security_groups = concat([aws_security_group.default.id], var.extra_security_groups)
  subnets         = var.subnet_ids
  tags            = var.tags
  idle_timeout    = var.idle_timeout

  access_logs {
    bucket  = var.access_logs_bucket
    enabled = var.access_logs_enabled
  }
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = element(concat(data.aws_acm_certificate.cert.*.arn, [""]), 0)
  ssl_policy        = var.ssl_policy
  
  routing_http_response_strict_transport_security_header_value = var.routing_http_response_strict_transport_security_header_value
  routing_http_response_access_control_allow_origin_header_value = var.routing_http_response_access_control_allow_origin_header_value
  routing_http_response_access_control_allow_methods_header_value = var.routing_http_response_access_control_allow_methods_header_value
  routing_http_response_access_control_allow_headers_header_value = var.routing_http_response_access_control_allow_headers_header_value
  routing_http_response_access_control_allow_credentials_header_value = var.routing_http_response_access_control_allow_credentials_header_value
  routing_http_response_access_control_expose_headers_header_value = var.routing_http_response_access_control_expose_headers_header_value
  routing_http_response_access_control_max_age_header_value = var.routing_http_response_access_control_max_age_header_value
  routing_http_response_content_security_policy_header_value = var.routing_http_response_content_security_policy_header_value
  routing_http_response_x_content_type_options_header_value = var.routing_http_response_x_content_type_options_header_value
  routing_http_response_x_frame_options_header_value = var.routing_http_response_x_frame_options_header_value
  default_action {
    target_group_arn = var.default_target_group_arn
    type             = "forward"
  }
}
