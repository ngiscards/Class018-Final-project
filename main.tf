# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Vpc-Insurance"
  }
}

# Create Public Subnet

resource "aws_subnet" "public_subnet1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-1a"
  tags = {
    Name = "Public-Subnet1"
  }
}
# Create Public Subnet

resource "aws_subnet" "public_subnet2c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "Public-Subnet2"
  }
}

# Create Private Subnet

resource "aws_subnet" "private_subnet1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-1a"
  tags = {
    Name = "Private-Subnet1"
  }
}
# Create Private Subnet

resource "aws_subnet" "private_subnet2c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "Private-Subnet2"
  }
}
# Create Private Subnet

resource "aws_subnet" "private_subnet3a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-west-1a"
  tags = {
    Name = "Private-Subnet3"
  }
}
# Create Private Subnet

resource "aws_subnet" "private_subnet4c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-west-1c"
  tags = {
    Name = "Private-Subnet4"
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Internet-Gateway"
  }
}

# Creating EIP

resource "aws_eip" "nat_gateway1" {
  vpc = true
}

# Creating NAT Gateway

resource "aws_nat_gateway" "nat_gateway1" {
  allocation_id = aws_eip.nat_gateway1.id
  subnet_id     = aws_subnet.public_subnet1a.id

  tags = {
    Name = "gw NAT"
  }
}



# #Route for NAT
# resource "aws_route" "nat_gateway1" {
#   route_table_id = aws_route_table.private_route_table.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id = aws_nat_gateway.nat_gateway1.id
# }
# #Route for NAT
# resource "aws_route" "nat_gateway2" {
#   route_table_id = aws_route_table.private_route_table.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id = aws_nat_gateway.nat_gateway2.id
# }


# Creating Public Route Table

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Public-route-Table"
  }
}

# Creating Private Route Table

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway1.id

  }

  tags = {
    Name = "Private-route-Table"
  }
}

# Route Table association with Public Subnet

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public_subnet1a.id
  route_table_id = aws_route_table.public_route_table.id
}
# Route Table association with Public Subnet

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public_subnet2c.id
  route_table_id = aws_route_table.public_route_table.id
}


# Route Table association with Private Subnet

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private_subnet1a.id
  route_table_id = aws_route_table.private_route_table.id
}
# Route Table association with Private Subnet

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private_subnet2c.id
  route_table_id = aws_route_table.private_route_table.id
}
# Route Table association with Private Subnet

resource "aws_route_table_association" "private3" {
  subnet_id      = aws_subnet.private_subnet3a.id
  route_table_id = aws_route_table.private_route_table.id
}
# Route Table association with Private Subnet

resource "aws_route_table_association" "private4" {
  subnet_id      = aws_subnet.private_subnet4c.id
  route_table_id = aws_route_table.private_route_table.id
}