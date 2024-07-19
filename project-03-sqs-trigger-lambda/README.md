


https://dev.to/aws-builders/amazon-sqs-to-aws-lambda-error-handling-3d4f


1. Send SQS message


    aws sqs send-message --queue-url https://sqs.eu-west-3.amazonaws.com/272235520632/terraform-example-queue --message-body "IOT-1 Temp: 51C"


2. Show CloudWatch log group Lambda