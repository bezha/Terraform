#----------------------------------------------------------
# Build 3 EC2 each on own AZ with docker CV
#
# Made by Vitalii Bezhanovych
#----------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "cv_turquoise" {
  ami                    = var.ami_image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.cv.id]
  user_data              = file("cv_turquoise.sh")
  key_name               = "CliKey"
  availability_zone      = "eu-central-1a"

  tags = {
    Name  = "CV Turquoise"
    Owner = "Vitalii Bezhanovych"
  }
}

resource "aws_instance" "cv_green" {
  ami                    = var.ami_image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.cv.id]
  user_data              = file("cv_green.sh")
  key_name               = "CliKey"
  availability_zone      = "eu-central-1b"

  tags = {
    Name  = "CV Green"
    Owner = "Vitalii Bezhanovych"
  }
}

resource "aws_instance" "cv_burgundy" {
  ami                    = var.ami_image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.cv.id]
  user_data              = file("cv_burgundy.sh")
  key_name               = "CliKey"
  availability_zone      = "eu-central-1c"

  tags = {
    Name  = "CV Burgundy"
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
    Project = "ELB CV"
  }
}

resource "aws_lb_target_group" "cv_target_group" {
  name     = "CV"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-24c53f4e"

  health_check {
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200-499"
  }

}

resource "aws_lb_target_group_attachment" "CV_turquoise" {
  target_group_arn = aws_lb_target_group.cv_target_group.arn
  target_id        = aws_instance.cv_turquoise.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "CV_green" {
  target_group_arn = aws_lb_target_group.cv_target_group.arn
  target_id        = aws_instance.cv_green.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "CV_burgundy" {
  target_group_arn = aws_lb_target_group.cv_target_group.arn
  target_id        = aws_instance.cv_burgundy.id
  port             = 80
}

# ALB for the web servers
resource "aws_lb" "CV" {
  name               = "CV"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.cv.id]
  subnets            = ["subnet-3e736b43", "subnet-f2a04fbe", "subnet-e05efc8a"]
  enable_http2       = false

  tags = {
    Name = "CV"
  }
}

resource "aws_lb_listener" "CV" {
  load_balancer_arn = aws_lb.CV.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.cv_target_group.id
    type             = "forward"
  }
}
