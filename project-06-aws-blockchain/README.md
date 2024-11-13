
# Terraform

## Work in progress


Next time install a blockchain



## Tuto

1.
         cd terraform

         terraform validate

         terraform plan

         terraform apply --auto-approve


2. Ansible test

        cd ansible 

        ansible -m ping aws_ec2

Ou

        cd terraform

        ansible -m ping aws_ec2 -i inventory.ini


3. Apply ansible

        ansible-playbook playbook.yaml

4. Curl and see nginx up

       curl http://<ip>



Shutdown 

       terraform destroy





## Source


https://aku.dev/create_aws_ec2_instance_with_terraform/

https://medium.com/@mudasirhaji/provision-vpc-security-groups-ec2-instance-and-many-more-using-terraform-6efef2aad719

Note :

Ami Catalog

https://eu-west-3.console.aws.amazon.com/ec2/home?region=eu-west-3#AMICatalog:


### Ansible :

https://dev.to/mariehposa/how-to-deploy-an-application-to-aws-ec2-instance-using-terraform-and-ansible-3e78



### Great Tuto Ansible + terraform

https://www.linkedin.com/pulse/how-provision-configure-aws-ec2-instance-using-terraform-%D0%B8%D0%B2%D0%B0%D0%BD%D0%BE%D0%B2/

https://github.com/slavnyj/aws_ec2_terraform_ansible

### Blockchain Ethereum

https://medium.com/meetech/cr%C3%A9er-sa-blockchain-ethereum-sur-aws-en-10-minutes-1bf3bdebc22d


Tuto ethereum POA

https://chiheb-nexus.github.io/ethereumpoa/