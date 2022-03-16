# --------------- apiops-aws-mkp-subscriptions Role --------------------
data "aws_iam_policy_document" "apiops-aws-mkp-subscriptions" {
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

resource "aws_iam_role" "apiops-aws-mkp-subscriptions" {
  name               = "apiops-aws-mkp-subscriptions-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role.json
}

resource "aws_iam_policy" "apiops-aws-mkp-subscriptions" {
  name   = "apiops-aws-mkp-subscriptions-lambda-execute-policy"
  policy = data.aws_iam_policy_document.apiops-aws-mkp-signup.json
}

resource "aws_iam_role_policy_attachment" "apiops-aws-mkp-subscriptions-execute" {
  policy_arn = aws_iam_policy.apiops-aws-mkp-subscriptions.arn
  role       = aws_iam_role.apiops-aws-mkp-subscriptions.name
}
# --------------- End Role --------------------