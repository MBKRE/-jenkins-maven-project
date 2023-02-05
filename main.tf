#declare the provider here as i am using single terraform file all the prerequisites here
provider "aws" {
#region where you want to make your server
  region     = "us-east-1"
#uses jenkins instance role for terraform execution
   access_key = var.accesskey
   secret_key = var.secretkey
  
}
variable "accesskey" {
}
variable "secretkey" {
}
#VPC
resource "aws_vpc" "hello_vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "Helloworld-vpc"
  }

}

#Public Subnet
resource "aws_subnet" "hello_sub" {
  vpc_id            = aws_vpc.hello_vpc.id
  cidr_block        = "10.1.0.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Hello-subnet"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "hello_ig" {
  vpc_id = aws_vpc.hello_vpc.id


  tags = {
    Name = "hello-ig"
  }
}

#Route Table
resource "aws_route_table" "hello_pub_rt" {
  vpc_id = aws_vpc.hello_vpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hello_ig.id
  }

  tags = {
    Name = "hello-public-rt"
  }
}

#Route table association
resource "aws_route_table_association" "hello_public_rt" {
  subnet_id      = aws_subnet.hello_sub.id
  route_table_id = aws_route_table.hello_pub_rt.id
}


#Security Group for EC2
resource "aws_security_group" "hello_sg" {
  vpc_id = aws_vpc.hello_vpc.id

  ingress {
    from_port   = 22
    to_port     = 8081
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
    Name = "hello-security-group"
  }
}

#name of the resource that have been created
resource "aws_instance" "myfirsttec2" {
#ami is for ubuntu
  ami                    = "ami-00874d747dde814fa"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.hello_sub.id
  associate_public_ip_address = "true"
  vpc_security_group_ids = [aws_security_group.hello_sg.id]
  key_name               = "helloworld"
  user_data              = file("script_n.sh")


  tags = {
    Name = "terraform-mynewserver"



 }
}
