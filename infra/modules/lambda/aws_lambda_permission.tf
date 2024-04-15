resource "aws_lambda_permission" "apigateway-to-lambda" {
  statement_id  = "AllowAPIGatewayGetTrApi"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_execution_arn}/*"
}
