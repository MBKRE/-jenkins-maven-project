#declare the provider here as i am using single terraform file all the prerequisites here
provider "aws" {
#region where you want to make your server
  region     = "us-east-1"
#uses jenkins instance role for terraform execution
  
}
#name of the resource that have been created
resource "aws_instance" "myfirsttec2" {
#ami is for ubuntu
  ami                    = "ami-00874d747dde814fa"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = "bharat"
  user_data              = file("script_n.sh")


  tags = {
    Name = "terraform-mynewserver"



 }
}
