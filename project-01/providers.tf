terraform{
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
        archive = { //The archive provider will give us a Terraform data source for zipping Lambda function code.
            source  = "hashicorp/archive"
            version = "~> 2.0.0"
        }
    }
}
provider "aws" {
    region = var.region
}