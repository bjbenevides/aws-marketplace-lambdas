variable "s3_bucket_name_signup" {
  type    = string
  default = "apiops-aws-mkp-signup"
}

variable "s3_bucket_name_subscriptions" {
  type    = string
  default = "apiops-aws-mkp-s3-subscriptions"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_profile" {
  type    = string
  default = "pessoal"
}

