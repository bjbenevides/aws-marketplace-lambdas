# ------ Bucket apiops-aws-mkp-signup ----- #
resource "aws_s3_bucket" "apiops-aws-mkp-signup" {
  bucket        = var.s3_bucket_name_signup
  force_destroy = true
  tags          = local.common_tags
}
resource "aws_s3_bucket_acl" "apiops-aws-mkp-signup_acl" {
  bucket = aws_s3_bucket.apiops-aws-mkp-signup.id
  acl    = "private"
}
resource "aws_s3_object" "apiops-aws-mkp-signup_object" {
  bucket = aws_s3_bucket.apiops-aws-mkp-signup.id
  key    = "apiops-aws-mkp-signup-artefato.zip"
  source = "files/apiops-aws-mkp-signup-artefato.zip"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("files/apiops-aws-mkp-signup-artefato.zip")
}

# ------ Bucket apiops-aws-mkp-subscriptions ----- #
resource "aws_s3_bucket" "apiops-aws-mkp-subscriptions" {
  bucket        = var.s3_bucket_name_subscriptions
  force_destroy = true
  tags          = local.common_tags
}
resource "aws_s3_bucket_acl" "apiops-aws-mkp-subscriptions_acl" {
  bucket = aws_s3_bucket.apiops-aws-mkp-subscriptions.id
  acl    = "private"
}