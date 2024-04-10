resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.main_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
