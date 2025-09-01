

#create a vpc
resource "aws_vpc" "my_vpc"{
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_vpc"
  }
}

# First Private Subnet (AZ a)
resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private_subnet_a"
  }
}

# Second Private Subnet (AZ b)
resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private_subnet_b"
  }
}

#public subnet
resource "aws_subnet" "public_subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "public_subnet"
  }
  
}

#internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_igw"
  }
}

# routing table
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  } 
}

resource "aws_route_table_association" "public_sub" {
  route_table_id = aws_route_table.my-rt.id
  subnet_id = aws_subnet.public_subnet.id
  
}

