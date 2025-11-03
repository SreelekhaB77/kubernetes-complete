provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecr_repository" "frontend_repo" {
  name = "react-frontend"
}

resource "aws_ecr_repository" "backend_repo" {
  name = "flask-backend"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = ""
  cluster_version = "1.30"
  subnets         = ["subnet-123", "subnet-456"]
  vpc_id          = "vpc-xxx"
  manage_aws_auth = true
}
