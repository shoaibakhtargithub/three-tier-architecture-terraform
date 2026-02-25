# Create Key Pair in AWS using your local public key
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file("~/.ssh/my-strapi-key.pub")
}

# Backend EC2 Instance
resource "aws_instance" "backend" {
  ami           = "ami-017535a27f2ac0ce3"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # Use the key created above
  key_name = aws_key_pair.my_key.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              curl -sL https://rpm.nodesource.com/setup_18.x | bash -
              yum install -y nodejs git
              cd /home/ec2-user
              git clone https://github.com/shoaibakhtargithub/backend-app
              cd backend-app
              npm install
              nohup npm start > app.log 2>&1 &
              EOF

  tags = {
    Name = "backend-ec2"
  }
}