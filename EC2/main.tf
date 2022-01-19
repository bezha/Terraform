#----------------------------------------------------------
# Build EC2 with docker inside
#
# Made by Vitalii Bezhanovych
#----------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "turquoise" {
  ami                    = "ami-05cafdf7c9f772ad2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.cv.id]
  user_data              = file("turquoise.sh")
  key_name               = "CliKey"
  availability_zone      = "eu-central-1a"

  tags = {
    Name  = "Test EC2"
    Owner = "Vitalii Bezhanovych"
  }
}

resource "aws_security_group" "cv" {
  name        = "CV Security Group"
  description = "CV Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name    = "Security Group"
    Owner   = "Vitalii Bezhanovych"
  }
}