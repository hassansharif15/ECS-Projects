# modules/vpc/variables.tf

# CIDRs and AZs
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the main VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  type        = string
  description = "CIDR block for public subnet 1"
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  type        = string
  description = "CIDR block for public subnet 2"
  default     = "10.0.2.0/24"
}

variable "public_subnet_1_az" {
  type        = string
  description = "Availability zone for public subnet 1"
  default     = "eu-west-2a"
}

variable "public_subnet_2_az" {
  type        = string
  description = "Availability zone for public subnet 2"
  default     = "eu-west-2b"
}

# Tag names (so you can change naming easily later if you want)
variable "vpc_name" {
  type        = string
  description = "Tag name for the VPC"
  default     = "main_vpc"
}

variable "public_subnet_1_name" {
  type        = string
  description = "Tag name for public subnet 1"
  default     = "public-subnet-1"
}

variable "public_subnet_2_name" {
  type        = string
  description = "Tag name for public subnet 2"
  default     = "public-subnet-2"
}

variable "igw_name" {
  type        = string
  description = "Tag name for Internet Gateway"
  default     = "main-igw"
}

variable "public_rt_name" {
  type        = string
  description = "Tag name for public route table"
  default     = "public-route-table"
}

variable "nat_eip_name" {
  type        = string
  description = "Tag name for NAT EIP"
  default     = "nat-eip"
}

variable "nat_gw_name" {
  type        = string
  description = "Tag name for NAT Gateway"
  default     = "main-nat-gateway"
}

# Private subnet CIDRs and AZs
variable "private_subnet_1_cidr" {
  type        = string
  description = "CIDR block for private subnet 1"
  default     = "10.0.11.0/24"
}

variable "private_subnet_2_cidr" {
  type        = string
  description = "CIDR block for private subnet 2"
  default     = "10.0.12.0/24"
}

variable "private_subnet_1_az" {
  type        = string
  description = "Availability zone for private subnet 1"
  default     = "eu-west-2a"
}

variable "private_subnet_2_az" {
  type        = string
  description = "Availability zone for private subnet 2"
  default     = "eu-west-2b"
}

# Tag names for private subnets + private RT
variable "private_subnet_1_name" {
  type        = string
  description = "Tag name for private subnet 1"
  default     = "private-subnet-1"
}

variable "private_subnet_2_name" {
  type        = string
  description = "Tag name for private subnet 2"
  default     = "private-subnet-2"
}

variable "private_rt_name" {
  type        = string
  description = "Tag name for private route table"
  default     = "private-route-table"
}
