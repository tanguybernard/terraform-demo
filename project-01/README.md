

## Installation

## Run

1. Initializing/updating Terraform project

        terraform init

Note: When a new modules is declared, terraform init

2. Validating Terraform project

        terraform validate

3. Planning Terraform execution

       terraform plan

4. Apply

       terraform apply --auto-approve

Note: If you don’t provide __--auto-approve__ flag, you would have to manually approve the configuration to be applied, after running the command.


5. Show Gateway created by terraform

       aws apigateway get-rest-apis

   Response :

         {
            "items": [
               {
                  "id": "wk357buhki",
                  "name": "terraform-api-gateway-example",
                  "createdDate": "2024-07-01T10:16:11+02:00",
                  "apiKeySource": "HEADER",
                  "endpointConfiguration": {
                     "types": [
                        "EDGE"
                     ]
                  },
                  "disableExecuteApiEndpoint": false,
                  "rootResourceId": "5t2ex1frb5"
               }
            ]
         }

6. Destroying Terraform managed resources

       terraform destroy --auto-approve


## Project change

   terraform validate
   terraform plan
   terraform apply --auto-approve



## Invoke lambda

      aws lambda invoke --function-name MovieLambda response.json


## Get AWS Account ID


      aws sts get-caller-identity --query "Account" --output text

## Get token Cognito

      aws cognito-idp initiate-auth --auth-flow USER_PASSWORD_AUTH --auth-parameters 'USERNAME=user12345,PASSWORD=password!12345' --client-id abcd123azerty --output json

## Credits

https://hands-on.cloud/terraform-api-gateway/



