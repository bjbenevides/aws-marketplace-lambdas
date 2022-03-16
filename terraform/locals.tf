locals {
  lambdas_signup_path        = "${path.module}/../app/lambda"
  lambdas_subscriptions_path = "${path.module}/../app/lambda"

  common_tags = {
    Scost = "marketplace"
  }
}