resource "aws_api_gateway_rest_api" "apiops-aws-mkp_api" {
  name = "apiops-aws-mkp_api"
}

resource "aws_api_gateway_resource" "subscriptions" {
  rest_api_id = aws_api_gateway_rest_api.apiops-aws-mkp_api.id
  parent_id   = aws_api_gateway_rest_api.apiops-aws-mkp_api.root_resource_id
  path_part   = "subscriptions"
}

resource "aws_api_gateway_resource" "signup" {
  rest_api_id = aws_api_gateway_rest_api.apiops-aws-mkp_api.id
  parent_id   = aws_api_gateway_rest_api.apiops-aws-mkp_api.root_resource_id
  path_part   = "signup"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.apiops-aws-mkp_api.id
  resource_id   = aws_api_gateway_resource.subscriptions.id
  authorization = "NONE"
  http_method   = "POST"
  api_key_required = false
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.apiops-aws-mkp_api.id
  resource_id             = aws_api_gateway_resource.subscriptions.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.apiops-aws-mkp-subscriptions.invoke_arn
}

resource "aws_api_gateway_method_response" "response_202" {
  rest_api_id = aws_api_gateway_rest_api.apiops-aws-mkp_api.id
  resource_id = aws_api_gateway_resource.subscriptions.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "202"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "intregration_response_202" {
  depends_on  = [aws_api_gateway_method_response.response_202]
  rest_api_id = aws_api_gateway_rest_api.apiops-aws-mkp_api.id
  resource_id = aws_api_gateway_resource.subscriptions.id
  http_method = aws_api_gateway_method_response.response_202.http_method
  status_code = aws_api_gateway_method_response.response_202.status_code
}

resource "aws_api_gateway_method_response" "response_400" {
  rest_api_id = aws_api_gateway_rest_api.apiops-aws-mkp_api.id
  resource_id = aws_api_gateway_resource.subscriptions.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "400"
  
  response_models = {
      "application/json" = "Error"
  }    
}
resource "aws_api_gateway_integration_response" "intregration_response_400" {
  depends_on  = [aws_api_gateway_method_response.response_400]
  rest_api_id = aws_api_gateway_rest_api.apiops-aws-mkp_api.id
  resource_id = aws_api_gateway_resource.subscriptions.id
  http_method = aws_api_gateway_method_response.response_400.http_method
  status_code = aws_api_gateway_method_response.response_400.status_code
  selection_pattern = ".*\"status\":400.*"
}

resource "aws_api_gateway_method_response" "response_422" {
  rest_api_id = aws_api_gateway_rest_api.apiops-aws-mkp_api.id
  resource_id = aws_api_gateway_resource.subscriptions.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "422"

  response_models = {
      "application/json" = "Error"
  }
}
resource "aws_api_gateway_integration_response" "intregration_response_422" {
  depends_on  = [aws_api_gateway_method_response.response_422]
  rest_api_id = aws_api_gateway_rest_api.apiops-aws-mkp_api.id
  resource_id = aws_api_gateway_resource.subscriptions.id
  http_method = aws_api_gateway_method_response.response_422.http_method
  status_code = aws_api_gateway_method_response.response_422.status_code
  selection_pattern = ".*\"status\":422.*"
}

resource "aws_api_gateway_method_response" "response_500" {
  rest_api_id = aws_api_gateway_rest_api.apiops-aws-mkp_api.id
  resource_id = aws_api_gateway_resource.subscriptions.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "500"

  response_models = {
      "application/json" = "Error"
  } 
}
resource "aws_api_gateway_integration_response" "intregration_response_500" {
  depends_on  = [aws_api_gateway_method_response.response_500]
  rest_api_id = aws_api_gateway_rest_api.apiops-aws-mkp_api.id
  resource_id = aws_api_gateway_resource.subscriptions.id
  http_method = aws_api_gateway_method_response.response_500.http_method
  status_code = aws_api_gateway_method_response.response_500.status_code
  selection_pattern = ".*\"status\":500.*"
}

resource "aws_api_gateway_deployment" "deploy" {
  rest_api_id = aws_api_gateway_rest_api.apiops-aws-mkp_api.id
  stage_name  = "dev"

  depends_on = [aws_api_gateway_integration.integration]
}