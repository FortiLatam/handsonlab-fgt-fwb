// AWS VPC FGT
resource "aws_vpc" "fgtvm-vpc" {
  cidr_block           = var.vpccidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  instance_tenancy     = "default"
  tags = {
    Name = "Secure VPC"
  }
}

resource "aws_subnet" "publicsubnetaz1" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.publiccidraz1
  availability_zone = var.az1
  tags = {
    Name = "Secure public sub"
  }
}

resource "aws_subnet" "privatesubnetaz1" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.privatecidraz1
  availability_zone = var.az1
  tags = {
    Name = "Secure private sub"
  }
}

// AWS VPC Legacy
resource "aws_vpc" "legacyvpc" {
  cidr_block           = var.vpclegcidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  instance_tenancy     = "default"
  tags = {
    Name = "Legacy VPC"
  }
}

resource "aws_subnet" "legacysubpub" {
  vpc_id            = aws_vpc.legacyvpc.id
  cidr_block        = var.publiclegcidraz1
  availability_zone = var.az1
  tags = {
    Name = "Legacy public sub"
  }
}

