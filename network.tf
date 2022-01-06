// Creating Internet Gateway for FortiGate VPC
resource "aws_internet_gateway" "fgtvmigw" {
  vpc_id = aws_vpc.fgtvm-vpc.id
  tags = {
    Name = "fgtvm-igw"
  }
}

// Creating Internet Gateway for Legacy VPC
resource "aws_internet_gateway" "legacyvpcigw" {
  vpc_id = aws_vpc.legacyvpc.id
  tags = {
    Name = "legacy-vpc-igw"
  }
}

####### Route Table FortiGate VPC #######
resource "aws_route_table" "fgtvmpublicrt" {
  vpc_id = aws_vpc.fgtvm-vpc.id

  tags = {
    Name = "fgtvm-public-rt"
  }
}

resource "aws_route_table" "fgtvmprivatert" {
  vpc_id = aws_vpc.fgtvm-vpc.id

  tags = {
    Name = "fgtvm-private-rt"
  }
}

resource "aws_route" "externalroute" {
  route_table_id         = aws_route_table.fgtvmpublicrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.fgtvmigw.id
}

resource "aws_route" "internalroute" {
  depends_on             = [aws_instance.fgtvm]
  route_table_id         = aws_route_table.fgtvmprivatert.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.eth1.id

}

resource "aws_route_table_association" "public1associate" {
  subnet_id      = aws_subnet.publicsubnetaz1.id
  route_table_id = aws_route_table.fgtvmpublicrt.id
}

resource "aws_route_table_association" "internalassociate" {
  subnet_id      = aws_subnet.privatesubnetaz1.id
  route_table_id = aws_route_table.fgtvmprivatert.id
}

resource "aws_eip" "FGTPublicIP" {
  depends_on        = [aws_instance.fgtvm]
  vpc               = true
  network_interface = aws_network_interface.eth0.id
}

####### Route Table Legacy VPC #########
//Create Route Table
resource "aws_route_table" "legacypubrt" {
  vpc_id = aws_vpc.legacyvpc.id

  tags = {
    Name = "legacy-public-rt"
  }
}

//Add internet route to it
resource "aws_route" "legacyexternalroute" {
  route_table_id         = aws_route_table.legacypubrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.legacyvpcigw.id
}

//Associate Route Table with Subnet
resource "aws_route_table_association" "legpub-associate" {
  subnet_id      = aws_subnet.legacysubpub.id
  route_table_id = aws_route_table.legacypubrt.id
}

######### Security Group #########

resource "aws_security_group" "public_allow" {
  name        = "Public Allow"
  description = "Public Allow traffic"
  vpc_id      = aws_vpc.fgtvm-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9443
    to_port     = 9443
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9080
    to_port     = 9080
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9081
    to_port     = 9081
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9001
    to_port     = 9001
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
  from_port = -1
  to_port = -1
  protocol = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public Allow"
  }
}


resource "aws_security_group" "public_allow_legacy" {
  name        = "Public Allow Legacy"
  description = "Public Allow legacy traffic"
  vpc_id      = aws_vpc.legacyvpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9001
    to_port     = 9001
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }
      
  ingress {
    from_port   = 1389
    to_port     = 1389
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  from_port = -1
  to_port = -1
  protocol = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public Allow Legacy"
  }
}


resource "aws_security_group" "allow_all" {
  name        = "Allow All"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.fgtvm-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public Allow"
  }
}
