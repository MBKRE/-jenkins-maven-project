provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA23RGQH2W44474E7B"
  secret_key = "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"
}

#VPC
resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Dev-vpc"
  }

}

#Public Subnet
resource "aws_subnet" "dev_sub" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Dev-subnet"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "dev_ig" {
  vpc_id = aws_vpc.dev_vpc.id


  tags = {
    Name = "dev-ig"
  }
}

#Route Table
resource "aws_route_table" "dev_pub_rt" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_ig.id
  }

  tags = {
    Name = "dev-public-rt"
  }
}

#Route table association
resource "aws_route_table_association" "dev_public_rt" {
  subnet_id      = aws_subnet.dev_sub.id
  route_table_id = aws_route_table.dev_pub_rt.id
}


#SecurityGroup for EC2
resource "aws_security_group" "dev_sg" {
  vpc_id = aws_vpc.dev_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev2-security-group"
  }
}

#EC2 with userdata
resource "aws_instance" "dev_ec2" {
  ami                         = "ami-0aa7d40eeae50c9a9"
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  subnet_id                   = aws_subnet.dev_sub.id
  vpc_security_group_ids      = [aws_security_group.dev_sg.id]

  user_data = <<EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo service httpd start
echo "Hello World" | sudo tee /var/www/html/index.html
EOF
  tags = {
    Name = "dev-instance"
  }
}
