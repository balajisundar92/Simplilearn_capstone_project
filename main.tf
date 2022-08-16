provider "aws" {
  region = var.aws_region
}

#Create security group with firewall rules
resource "aws_security_group" "security_jenkins_port" {
  name        = "security_jenkins_port"
  description = "security group for jenkins"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = "security_jenkins_port"
  }
}

resource "aws_key_pair" "my-awsEC2" {
  key_name = "my-awsEC2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFoYZW6qwowQP/ni4Npf3Es1tHDTLfZP0m7OzY1NpgA/9u4o7C1XidS7oJ3zUYwHsMSnd6HTxUjvXXpFGZyUQBmpU8MFPi8aXe+lVQkBQqMVtFhceJOawAH5LigFym5GuJiqafTyoopl1pQyChjRI1ePyAkxKaecRelFuzAG7ZUlN/FBkZD6PArJRfp+Yj/ba02X1gptR7COm7EjuST9dRHxAe99/9765IVPDNJxm1Pwb9qnHaT1h2mB8zfIktUp9HrR2bM6GxE4WM54+8iqvqTwWj9lA/OzEG1J6pz9oaWOCyOexz8kyI3sLTZKGMa8l1EttxEU0MJz/bQ+52kW900OCrPGSp/RPq8IkC930PhRnPEks0psCWrZmQSVSvLhDZs+xxqMFWP6eKN6JRZiIHC7Q9OXspPFefSlfc1x80fGk8KDgQtf8ssscgWUNU9nSH8oIGlCuLxJjSLYJq/uZepgLFmKg6qgwz/Eh6yhI9QamMP2ORpAp5bPpPdxdnAAs= balaji@balaji-ubuntu"
}

resource "aws_instance" "myFirstInstance" {
  ami           = "ami-02f3416038bdb17fb"
  instance_type = var.instance_type
  security_groups= [ "security_jenkins_port"]
  tags= {
    Name = "jenkins_instance"
  }
}

# Create Elastic IP address
resource "aws_eip" "myFirstInstance" {
  vpc      = true
  instance = aws_instance.myFirstInstance.id
tags= {
    Name = "jenkins_elstic_ip"
  }
}
