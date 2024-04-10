data "archive_file" "lambda" {
  type        = "zip"
  source_file = "./modules/lambda/src"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "main" {
  filename         = "lambda_function_payload.zip"
  function_name    = "lambda_function"
  description      = "lambda_function"
  role             = var.iam_role_lambda
  handler          = "index.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  timeout          = 10
  runtime          = "python3.9"

  environment {
    variables = {
      db_host = var.db_address
      db_user = var.db_username
      db_pass = var.db_password
      db_name = var.db_name
    }
  }
  tags = {
    Name = "${var.app_name}-lamdba"
  }
}
