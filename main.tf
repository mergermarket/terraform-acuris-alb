module "aws_acm_certificate_arn" {
  source      = "./modules/aws_acm_certificate_arn"
  run_data    = var.run_data
  domain_name = var.certificate_domain_name
}

resource "aws_alb" "alb" {
  name     = replace(replace(var.name, "/(.{0,32}).*/", "$1"), "/^-+|-+$/", "")
  internal = var.internal
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  security_groups = [concat([aws_security_group.default.id], var.extra_security_groups)]
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
  certificate_arn   = module.aws_acm_certificate_arn.arn

  default_action {
    target_group_arn = var.default_target_group_arn
    type             = "forward"
  }
}

