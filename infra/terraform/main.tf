# --- AWS Provider ---
provider "aws" {
  region = "us-east-1"
}

# --- Get default VPC (or you can use a specific one if you prefer) ---
data "aws_vpc" "default" {
  default = true
}

# --- EKS Cluster ---
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.0"

  cluster_name    = "k8s_with_terraform"
  cluster_version = "1.30"

  vpc_id     = data.aws_vpc.default.id
  subnet_ids = [
    "subnet-0092bf770dcbf8957", # us-east-1a
    "subnet-0d64f003cca0e3b93", # us-east-1b
    "subnet-0408972900ec39997"  # us-east-1c
  ]

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      max_size       = 2
      min_size       = 1
      instance_types = ["t3.small"]
    }
  }

  tags = {
    Environment = "dev"
    Project     = "eks-demo"
  }
}

# --- ECR Repository ---
resource "aws_ecr_repository" "app_repo" {
  name                 = "my-app-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "my-app-repo"
    Environment = "dev"
  }
}

