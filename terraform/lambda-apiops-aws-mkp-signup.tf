#data "archive_file" "apiops-aws-mkp-signup" {
#  type        = "zip"
#  source_file = "${local.lambdas_signup_path}/apiops-aws-mkp-signup/index.js" #Especificar o caminho do js, em /app
#  output_path = "files/apiops-aws-mkp-signup-artefato.zip"                    #Especificar o path do artefato
#}


data "aws_s3_object" "apiops-aws-mkp-signup" {
  depends_on = [aws_s3_object.apiops-aws-mkp-signup_object]
  bucket     = aws_s3_bucket.apiops-aws-mkp-signup.id
  key        = "apiops-aws-mkp-signup-artefato.zip"
}

resource "aws_lambda_function" "apiops-aws-mkp-signup" {
  function_name = "apiops-aws-mkp-signup"
  handler       = "index.handler"
  role          = aws_iam_role.apiops-aws-mkp-signup.arn
  runtime       = "nodejs14.x"

  #filename         = data.archive_file.apiops-aws-mkp-signup.output_path
  #source_code_hash = data.archive_file.apiops-aws-mkp-signup.output_base64sha256

  s3_bucket         = data.aws_s3_object.apiops-aws-mkp-signup.bucket
  s3_key            = data.aws_s3_object.apiops-aws-mkp-signup.key
  s3_object_version = data.aws_s3_object.apiops-aws-mkp-signup.version_id

  tags = local.common_tags
}