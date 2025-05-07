# required
variable "name" {
  description = "The name of the ALB. This name must be unique within your AWS account, can have a maximum of 32 characters"
  type        = string
}

variable "vpc_id" {
  description = "The id of the VPC that the desired security group belongs to"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to attach to the ALB"
  type        = list(string)
}

variable "certificate_domain_name" {
  description = "Domain name as used in AWS ACM Certificate - this will be used by Terraform Data Source to resolve the actual certificate ARN"
  type        = string
}

variable "default_target_group_arn" {
  description = "The ARN of the default Target Group to which to route traffic"
  type        = string
}

# optional
variable "internal" {
  description = "If true, the ALB will be internal"
  type        = string
  default     = "true"
}

variable "extra_security_groups" {
  description = "Extra security groups to be attached to ALB"
  type        = list(string)
  default     = [""]
}

variable "access_logs_bucket" {
  description = "An S3 bucket to send access logs to"
  default     = ""
}

variable "access_logs_enabled" {
  description = "Whether or not to enable access logs"
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  type        = string
  default     = "60"
}

variable "run_data" {
  description = "Used to switch off data resources when unit testing"
  default     = true
}

variable "ssl_policy" {
  description = "The name of the SSL policy that defines which ciphers and protocols are supported. The default is ELBSecurityPolicy-2016-08"
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}

variable "routing_http_response_server_enabled" {
  description = "Whether or not to enable the HTTP response server."
  type        = string
  default     = "true"
}

variable "routing_http_response_strict_transport_security_header_value" {
  description = "The value of the Strict-Transport-Security header to be used in the HTTP response."
  type        = string
  default     = ""
}

variable "routing_http_response_access_control_allow_origin_header_value" {
  description = "The value of the Access-Control-Allow-Origin header to be used in the HTTP response."
  type        = string
  default     = ""
}

variable "routing_http_response_access_control_allow_methods_header_value" {
  description = "The value of the Access-Control-Allow-Methods header to be used in the HTTP response."
  type        = string
  default     = ""
}

variable "routing_http_response_access_control_allow_headers_header_value" {
  description = "The value of the Access-Control-Allow-Headers header to be used in the HTTP response."
  type        = string
  default     = ""
}

variable "routing_http_response_access_control_allow_credentials_header_value" {
  description = "The value of the Access-Control-Allow-Credentials header to be used in the HTTP response."
  type        = string
  default     = ""
}

variable "routing_http_response_access_control_expose_headers_header_value" {
  description = "The value of the Access-Control-Expose-Headers header to be used in the HTTP response."
  type        = string
  default     = ""
}

variable "routing_http_response_access_control_max_age_header_value" {
  description = "The value of the Access-Control-Max-Age header to be used in the HTTP response."
  type        = string
  default     = ""
}

variable "routing_http_response_content_security_policy_header_value" {
  description = "The value of the Content-Security-Policy header to be used in the HTTP response."
  type        = string
  default     = ""
}

variable "routing_http_response_x_content_type_options_header_value" {
  description = "The value of the X-Content-Type-Options header to be used in the HTTP response."
  type        = string
  default     = ""
}

variable "routing_http_response_x_frame_options_header_value" {
  description = "The value of the X-Frame-Options header to be used in the HTTP response."
  type        = string
  default     = ""
}

# we are not providing support for customizing routing_http_request_x_amzn_mtls_clientcert* attributes.check "
