resource "aws_instance" "backend" {
  ami           = "ami-00ca32bbc84273381" # Amazon Linux 2
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name      = "my-key" # replace with your EC2 key pair name

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
