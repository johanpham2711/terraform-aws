resource "aws_iam_role" "lambda_edge" {
  name = "AWSLambdaEdgeRole"
  path = "/service-role/"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "edgelambda.amazonaws.com",
            "lambda.amazonaws.com",
          ]
        },
        "Action" : "sts:AssumeRole",
      }
    ]
  })

  inline_policy {
    name = "AWSLambdaEdgeInlinePolicy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect : "Allow",
          Action : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          Resource : [
            "arn:aws:logs:*:*:*"
          ]
        }
      ]
    })
  }
}

data "archive_file" "zip_file_for_lambda_viewer_request" {
  type        = "zip"
  source_file = "functions/viewer-request.js"
  output_path = "functions/viewer-request.zip"
}

data "archive_file" "zip_file_for_lambda_origin_request" {
  type        = "zip"
  source_file = "functions/origin-request.js"
  output_path = "functions/origin-request.zip"
}

data "archive_file" "zip_file_for_lambda_origin_response" {
  type        = "zip"
  source_file = "functions/origin-response.js"
  output_path = "functions/origin-response.zip"
}
