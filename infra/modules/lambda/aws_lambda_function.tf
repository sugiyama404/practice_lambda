data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "./modules/lambda/src"
  output_path = "./modules/lambda/src/lambda_function_payload.zip"
}

resource "aws_lambda_function" "main" {
  filename         = "./modules/lambda/src/lambda_function_payload.zip"
  function_name    = "lambda_function"
  description      = "lambda_function"
  role             = var.iam_role_lambda
  architectures    = ["x86_64"]
  handler          = "index.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  timeout          = 30
  runtime          = "python3.9"
  # layers           = [aws_lambda_layer_version.pymysql.arn]

  vpc_config {
    subnet_ids         = [var.subnet_public_subnet_1a_id]
    security_group_ids = [var.sg_lambda_id]
  }

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
