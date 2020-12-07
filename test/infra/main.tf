terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version                     = ">= 2.15"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_get_ec2_platforms      = true
  skip_region_validation      = true
  skip_requesting_account_id  = true
  max_retries                 = 1
  access_key                  = "a"
  secret_key                  = "a"
  region                      = "eu-west-1"
}

module "alb_test" {
  source = "../.."

  name                     = "super-nice-alb-name"
  vpc_id                   = "foobar"
  subnet_ids               = ["subnet-b46032ec", "subnet-ca4311ef", "subnet-ba881221"]
  certificate_domain_name  = "mydomain.com"
  default_target_group_arn = "foobar"
  run_data                 = false
}

module "alb_test_with_tags" {
  source = "../.."

  name                     = "super-nice-alb-name"
  vpc_id                   = "foobar"
  subnet_ids               = ["subnet-b46032ec", "subnet-ca4311ef", "subnet-ba881221"]
  certificate_domain_name  = "mydomain.com"
  default_target_group_arn = "foobar"
  run_data                 = false

  tags = {
    component = "component"
    service   = "service"
  }
}

module "alb_test_network" {
  source = "../.."

  load_balancer_type       = "network"
  name                     = "super-nice-alb-name"
  vpc_id                   = "foobar"
  subnet_ids               = ["subnet-b46032ec", "subnet-ca4311ef", "subnet-ba881221"]
  certificate_domain_name  = "mydomain.com"
  default_target_group_arn = "foobar"
  run_data                 = false
}
