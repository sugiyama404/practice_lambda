resource "aws_api_gateway_rest_api" "main" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "api"
      version = "1.0"
    }
    paths = {
      "/path1" = {
        post = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            payloadFormatVersion = "1.0"
            type                 = "AWS_PROXY"
            uri                  = "${var.lambda_invoke_arn}"
            credentials          = "${var.iam_role_lambda}"
          }
        }
      }
    }
  })

  name = "main"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

