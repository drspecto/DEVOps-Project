provider "aws" {
  region = "ap-south-1"  
}

resource "aws_instance" "app_server" {
  ami           = "ami-0e35ddab05955cf57" 
  instance_type = "t2.micro"
  key_name      = aws_key_pair.edera-key.key_name 

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "CrecitaAppServer"
  }
}

resource "aws_security_group" "app_sg" {
  name        = "crecita-app-sg"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
