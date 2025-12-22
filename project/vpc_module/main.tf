##              Terraform capstone project



resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_tags
  }

}

resource "aws_internet_gateway" "custom_IGW" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = var.IGW_tags
  }
}


resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.public_cidr1
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_tags1
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.public_cidr2
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_tags2
  }
}

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = var.public_RT_tags
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.custom_IGW.id

}

resource "aws_route_table_association" "route_association1" {
  route_table_id = aws_route_table.public_RT.id
  subnet_id      = aws_subnet.public_subnet1.id
  depends_on     = [aws_subnet.public_subnet1]
}

resource "aws_route_table_association" "route_association2" {
  route_table_id = aws_route_table.public_RT.id
  subnet_id      = aws_subnet.public_subnet2.id
  depends_on     = [aws_subnet.public_subnet2]
}


resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.private_cidr1
  availability_zone       = "us-west-2a"

  tags = {
    Name = var.private_subnet_tags1
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.private_cidr2
  availability_zone       = "us-west-2b"

  tags = {
    Name = var.private_subnet_tags2
  }
}

resource "aws_eip" "EIP1" {
  domain   = "vpc"
  depends_on = [ aws_internet_gateway.custom_IGW ]

  tags = {
    Name = var.EIP1
  }
}

resource "aws_eip" "EIP2" {
  domain   = "vpc"
  depends_on = [ aws_internet_gateway.custom_IGW ]

  tags = {
    Name = var.EIP2
  }
}

resource "aws_nat_gateway" "NatGW1" {
  allocation_id = aws_eip.EIP1.id
  subnet_id = aws_subnet.public_subnet1.id

  tags = {
    Name = var.NatGW1
  }
}

resource "aws_nat_gateway" "NatGW2" {
  allocation_id = aws_eip.EIP2.id
  subnet_id = aws_subnet.public_subnet2.id

  tags = {
    Name = var.NatGW2
  }
}

resource "aws_route_table" "private_RT1"{
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = var.privateRT_tags1
  }
}

resource "aws_route" "private_route1" {
  route_table_id = aws_route_table.private_RT1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.NatGW1.id

}

resource "aws_route_table_association" "privateRT1_association" {
  route_table_id = aws_route_table.private_RT1.id
  subnet_id = aws_subnet.private_subnet1.id
  depends_on = [ aws_subnet.private_subnet1 ]
}

resource "aws_route_table" "private_RT2"{
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = var.privateRT_tags2
  }
}

resource "aws_route" "private_route2" {
  route_table_id = aws_route_table.private_RT2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.NatGW2.id

}

resource "aws_route_table_association" "private_RT2_association" {
  route_table_id = aws_route_table.private_RT2.id
  subnet_id = aws_subnet.private_subnet2.id
  depends_on = [ aws_subnet.private_subnet2 ]
}

resource "aws_security_group" "web_sg1" {
  name = "web_sg"
  description = "web security group allowing http traffic and all outbound traffic"
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "WebSG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_web_ipv4" {
  security_group_id = aws_security_group.web_sg1.id
  cidr_ipv4         = aws_vpc.custom_vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_web1_all_traffic_ipv4" {
  security_group_id = aws_security_group.web_sg1.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_security_group" "web_ALBSG" {
  name = "web_sg2"
  description = "ALB security group allowing http traffic and all outbound traffic"
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "ALBSG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_web2_ipv4" {
  security_group_id = aws_security_group.web_ALBSG.id
  cidr_ipv4         = aws_vpc.custom_vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_web2_all_traffic_ipv4" {
  security_group_id = aws_security_group.web_ALBSG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}


