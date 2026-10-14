variable "project_name" {
  description = "Name of the project, used in resource names"
  type        = string
}

variable "environment" {
  description = "dev, staging or prod"
  type        = string
}

variable "vpc_cidr" {
  description = "IP address range for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of Availability Zones to use"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "IP ranges for public subnets, one per AZ"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "IP ranges for private subnets, one per AZ"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Create a NAT Gateway (costs money per hour)"
  type        = bool
  default     = true
}
