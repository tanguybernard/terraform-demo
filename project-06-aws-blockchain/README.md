
# Terraform

## Work in progress


Next time install a blockchain



## Tuto

1.

        terraform apply


2. Ansible test

        ansible -m ping aws_ec2

Ou 
            
        ansible -m ping aws_ec2 -i inventory.ini


3. Apply ansible

        ansible-playbook playbook.yaml

4. Curl and see nginx up

       curl <ip>

5. Shutdown

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

