variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "Scani-np"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "staging"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "aws_region" {
  description = "aws region"
  type        = string
  default     = "ap-south-2"
}
variable "aws_ami" {
  description = "aws ami"
  type        = string
  default     = "ami-0be60c8d021e4ffdf"
}
