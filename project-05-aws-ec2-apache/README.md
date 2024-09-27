# Terraform Apache


## My PLAN

- Install Apache (Done)
- Install Node
- Deploy NextJs App
- Call Lambda from NextJS App

## Execution

1. Create key/pair

        https://docs.aws.amazon.com/fr_fr/AWSEC2/latest/UserGuide/create-key-pairs.html

1. Add KeyName on "variables.tf"" :

         variable "instance_key" {
             default = "TestKeyPairTerraformApacheSept2024"
         }

2. Get Access Key Secret Key


3. terraform init, validate, plan, apply

4. Destroy

        terraform destroy --auto-approve


## Tuto :

https://dev.to/chinmay13/deploying-a-linux-web-server-on-aws-ec2-instance-using-terraform-pgd




## Curl explained :


curl http://169.254.169.254/latest/meta-data/instance-id


https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-retrieval.html


Ami used Sept 2024 :
   
      Amazon Linux 2 AMI (HVM), SSD Volume Type (64-bit x86) Operating System
   
      ami-0e6b1122a66bc6c61