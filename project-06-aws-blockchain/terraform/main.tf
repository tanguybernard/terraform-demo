

// Create VPC
resource "aws_vpc" "my_VPC" {
  cidr_block = "10.10.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "AWS VPC"
  }
}



// Create Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_VPC.id

  tags = {
    Name = "my_igw"
  }
}

// Create Subnet

resource "aws_subnet" "my_Publicsubnet" {
  vpc_id     = aws_vpc.my_VPC.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "my_Publicsubnet"
  }
}

// Create Route Table
resource "aws_route_table" "my_routetable" {
  vpc_id = aws_vpc.my_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "my_routetable"
  }
}

//associate subnet with route table
resource "aws_route_table_association" "my-rt-association" {
  subnet_id      = aws_subnet.my_Publicsubnet.id
  route_table_id = aws_route_table.my_routetable.id
}

// Create Security Group
resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  description = "Allow SSH traffic"
  vpc_id = aws_vpc.my_VPC.id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}

resource "aws_security_group" "allow_http" {
  name = "allow_http"
  description = "Allow HTTP traffic"
  vpc_id = aws_vpc.my_VPC.id
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}

//Cette ressource génère une clé privée RSA.
resource "tls_private_key" "key" {
  algorithm = "RSA"
}

//Cette ressource AWS associe la clé publique au service EC2 d'AWS en tant que clé SSH, permettant de l'utiliser pour accéder aux instances EC2.
resource "aws_key_pair" "aws_key" {
  key_name = "ansible-ssh-key"
  public_key = tls_private_key.key.public_key_openssh
}


// Create EC2 Instance

resource "aws_instance" "myweb" {
  count = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type // Le minage demande un minimum de calcul, donc t2.micro pas possible, à minima utiliser une t2.medium
  associate_public_ip_address = true //nécessaire pour obtenir une adresse IP publique

  //clé ssh pour l'accès à la mahcine ec2
  key_name = aws_key_pair.aws_key.key_name
  subnet_id = aws_subnet.my_Publicsubnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id]


  tags = {
    Name = element(var.instance_tags, count.index)
  }
}