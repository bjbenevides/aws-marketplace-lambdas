data "archive_file" "apiops-aws-mkp-subscriptions" {
  type        = "zip"
  source_file = "${local.lambdas_subscriptions_path}/apiops-aws-mkp-subscriptions/main.go" #Especificar o caminho do js, em /app
  output_path = "files/apiops-aws-mkp-subscriptions-artefato.zip"                          #Especificar o path do artefato
}

#data "aws_s3_object" "apiops-aws-mkp-subscriptions" {
#  bucket = aws_s3_bucket.apiops-aws-mkp-subscriptions.id
#  key    = "apiops-aws-mkp-subscriptions-artefato.zip"
#}

resource "aws_lambda_function" "apiops-aws-mkp-subscriptions" {
  function_name = "apiops-aws-mkp-subscriptions"
  handler       = "main"
  role          = aws_iam_role.apiops-aws-mkp-subscriptions.arn
  runtime       = "go1.x"

  filename         = data.archive_file.apiops-aws-mkp-subscriptions.output_path
  source_code_hash = data.archive_file.apiops-aws-mkp-subscriptions.output_base64sha256

  #s3_bucket = data.aws_s3_object.apiops-aws-mkp-subscriptions.bucket
  #s3_key = data.aws_s3_object.apiops-aws-mkp-subscriptions.key
  #s3_object_version = data.aws_s3_object.apiops-aws-mkp-subscriptions.version_id

  tags = local.common_tags
}