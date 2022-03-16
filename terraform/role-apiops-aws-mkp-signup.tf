# --------------- apiops-aws-mkp-signup Role --------------------
data "aws_iam_policy_document" "apiops-aws-mkp-signup" {
  statement {
    sid       = "AllowS3AndSNSActions"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "s3:*",
      "sns:*",
    ]
  }

  statement {
    sid       = "AllowInvokingLambdas"
    effect    = "Allow"
    resources = ["arn:aws:lambda:*:*:function:*"]
    actions   = ["lambda:InvokeFunction"]
  }

  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_role" "apiops-aws-mkp-signup" {
  name               = "apiops-aws-mkp-signup-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role.json
}

resource "aws_iam_policy" "apiops-aws-mkp-signup" {
  name   = "apiops-aws-mkp-signup-lambda-execute-policy"
  policy = data.aws_iam_policy_document.apiops-aws-mkp-signup.json
}

resource "aws_iam_role_policy_attachment" "apiops-aws-mkp-signup-execute" {
  policy_arn = aws_iam_policy.apiops-aws-mkp-signup.arn
  role       = aws_iam_role.apiops-aws-mkp-signup.name
}
# --------------- End Role --------------------