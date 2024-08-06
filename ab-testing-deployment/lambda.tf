provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

resource "aws_lambda_function" "viewer_request_function" {
  function_name = "viewer-request-ab-testing"
  role          = aws_iam_role.lambda_edge.arn
  publish       = true

  handler          = "viewer-request.handler"
  runtime          = "nodejs18.x"
  filename         = "functions/viewer-request.zip"
  source_code_hash = filebase64sha256("functions/viewer-request.zip")

  provider = aws.us-east-1
}

resource "aws_lambda_function" "origin_request_function" {
  function_name = "origin-request-ab-testing"
  role          = aws_iam_role.lambda_edge.arn
  publish       = true

  handler          = "origin-request.handler"
  runtime          = "nodejs18.x"
  filename         = "functions/origin-request.zip"
  source_code_hash = filebase64sha256("functions/origin-request.zip")

  provider = aws.us-east-1
}

resource "aws_lambda_function" "origin_response_function" {
  function_name = "origin-response-ab-testing"
  role          = aws_iam_role.lambda_edge.arn
  publish       = true

  handler          = "origin-response.handler"
  runtime          = "nodejs18.x"
  filename         = "functions/origin-response.zip"
  source_code_hash = filebase64sha256("functions/origin-response.zip")

  provider = aws.us-east-1
}
