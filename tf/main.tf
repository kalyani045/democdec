resource "aws_instance" "ec2instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.tf-key-pair.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = local.userdata1
  #user_data = file("script.sh")

 tags = {
    Name = "${var.name}-instance"
  }
}
resource "aws_key_pair" "tf-key-pair" {
key_name = "${var.name}-key"
public_key = tls_private_key.this.public_key_openssh
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-085d79862c0ef8a61"

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-sg"
  }
}

  resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
  }


locals {

userdata1 = <<EOF
#!/bin/bash
  sudo yum update -y 
  sudo yum install httpd -y
  sudo systemctl start httpd
  sudo systemctl enable httpd

EOF

userdata2 = <<EOF
#!/bin/bash 
sudo yum udpate -y 
sudo amazon-linux-extras install nginx1 -y 
sudo systemctl start nginx 
sudo systemctl enable nginx

EOF
}