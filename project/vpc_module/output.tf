output "vpc_id"{
    value = aws_vpc.custom_vpc
}

output "public_subnet_1"{
    value = aws_subnet.public_subnet1
}

output "public_subnet_2"{
    value = aws_subnet.public_subnet2
}

output "private_subnet_1"{
    value = aws_subnet.private_subnet1
}

output "private_subnet_2"{
    value = aws_subnet.private_subnet1
}