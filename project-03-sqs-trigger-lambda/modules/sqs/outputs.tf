output "terraform_queue_arn" {
  value = aws_sqs_queue.terraform_queue.arn
}
