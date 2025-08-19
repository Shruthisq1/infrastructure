module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = ["ap-south-2a", "ap-south-2b", "ap-south-2c"]
  private_subnets = ["10.0.0.0/19","10.0.32.0/19","10.0.64.0/19"]
  public_subnets  = ["10.0.96.0/19","10.0.128.0/19","10.0.160.0/19"]

  
  enable_nat_gateway     = true
  single_nat_gateway     = false              
  one_nat_gateway_per_az = true              
  reuse_nat_ips         = true              
  
  
  external_nat_ip_ids = aws_eip.nat[*].id    

  enable_dns_hostnames   = true
  enable_dns_support     = true
  tags = {
    Environment = var.environment
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }
}


resource "aws_eip" "nat" {
  count = 3  
  domain   = "vpc"

  tags = {
    Name        = "${var.cluster_name}-nat-eip-${count.index + 1}"
    Environment = var.environment
  }
}