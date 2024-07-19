# Lambda function policy
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [

    {
      "Action": [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"
      ],
      "Effect": "Allow",
      "Resource": "${var.terraform_queue_arn}"
    },
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
# Lambda function role
resource "aws_iam_role" "iam_for_terraform_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


# Role to Policy attachment
resource "aws_iam_role_policy_attachment" "terraform_lambda_iam_policy_basic_execution" {
  role = aws_iam_role.iam_for_terraform_lambda.id
  policy_arn = aws_iam_policy.lambda_policy.arn
}

// Create an AWS lambda

resource "aws_lambda_function" "test_lambda" {
  filename         = "./zips/lambda.zip"
  function_name    = "BouncesLambda"
  role             = aws_iam_role.iam_for_terraform_lambda.arn
  runtime = "nodejs18.x"
  handler = "index.handler"
  source_code_hash = filebase64sha256("./zips/lambda.zip")
}
# Trigger
resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = var.terraform_queue_arn
  enabled          = true //immediately starts sending events to Lambda
  function_name    = aws_lambda_function.test_lambda.arn
  batch_size       = 1
}