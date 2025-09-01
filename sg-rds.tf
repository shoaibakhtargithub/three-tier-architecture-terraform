
# SG for RDS (only allow EC2 SG to connect on 3306 MySQL port)
resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.my_vpc.id
  name   = "rds-sg"

  ingress {
    description     = "MySQL from EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "rds-sg" }
}