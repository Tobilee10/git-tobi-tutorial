variable "vpc_cidr" {
  type        = string
  description = "custom vpc cidr block"
}

variable "vpc_tags" {
  type        = string
  description = "custom vpc tags"
  default     = "custom-vpc"
}

variable "IGW_tags" {
  type        = string
  description = "custom IGW tags"
  default     = "IGW-custom-VPC"
}

variable "public_cidr1" {
  type        = string
  description = "public subnet cidr block"

}

variable "public_subnet_tags1" {
  type        = string
  description = "public subnet tags"
  default     = "public_subnet_1"
}

variable "public_cidr2" {
  type        = string
  description = "public subnet cidr block"

}

variable "public_subnet_tags2" {
  type        = string
  description = "public subnet tags"
  default     = "public_subnet_2"
}

variable "public_RT_tags" {
  type        = string
  description = "public route table for public subnet"
  default     = "public_RT"
}


variable "private_cidr1" {
  type        = string
  description = "public subnet cidr block"

}

variable "private_subnet_tags1" {
  type        = string
  description = "private subnet tags"
  default     = "private_subnet_1"
}

variable "private_cidr2" {
  type        = string
  description = "private subnet cidr block"

}

variable "private_subnet_tags2" {
  type        = string
  description = "private subnet tags"
  default     = "private_subnet_2"
}

variable "EIP1" {
  type = string
  description = "Elastic ip for the NATGW"
  default = "EIP1"
}

variable "EIP2" {
  type = string
  description = "Elastic ip for the NATGW and EC2 Instances"
  default = "EIP2"
}

variable "NatGW1" {
  type = string
  description = "NATGW for allowing resources in the private subnet to have internet access. Deployed in a public subnet"
  default = "NATGW1"
  
}

variable "NatGW2" {
  type = string
  description = "NATGW for allowing resources in the private subnet to have internet access. Deployed in a public subnet"
  default = "NATGW2"
  
}

variable "privateRT_tags1" {
  type        = string
  description = "pprivate route table for private subnet"
  default     = "private_RT_1"
}

variable "privateRT_tags2" {
  type        = string
  description = "pprivate route table for private subnet"
  default     = "private_RT_2"
}

variable "instance_type" {
  type = string
  description = "instance type of the machine"
}