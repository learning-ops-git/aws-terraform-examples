data "aws_caller_identity" "current" {
    provider = aws.main
}

data "aws_lambda_function" "lambda_function" {
    provider      = aws.main
    function_name = "lambda-dev-function"
}