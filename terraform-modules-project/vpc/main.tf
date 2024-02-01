

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block =var.vpc_block
  tags = {
    Name = "ivolve-project"
  }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
  
}

#connect  public route table to internet gateway 
resource "aws_route_table" "main-route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.block-of-route-table
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "public_routetable"
  }
}

