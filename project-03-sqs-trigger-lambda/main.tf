module "sqs" {
  source = "./modules/sqs"
}

module "lambda_function" {
  source = "./modules/lambda"
  terraform_queue_arn = module.sqs.terraform_queue_arn
  depends_on = [
    module.sqs
  ]
}