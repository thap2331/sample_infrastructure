terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  #save tf states in a backend (allow versions in s3 bucket), also enable locking
#   backend "s3" {
#    bucket         = "infrastructure/dev"
#    key            = "state/terraform.tfstate"
#    region         = "us-west-1"
#    encrypt        = true
#    kms_key_id     = "alias/terraform-bucket-key"
#    dynamodb_table = "terraform-state"
#  }
}


provider "aws" {
  region = var.aws_region
}

module "my_vpc" {
  source = "../modules/vpc"
}

module "my_sg" {
  source = "../modules/sg"
  vpc_id = module.my_vpc.vpc_id
}

module "my_iam_profile" {
  source = "../modules/iam"
}

module "load_server" {
  source                 = "../modules/entries_load_server"
  subnet_id              = module.my_vpc.public_subnet_id
  vpc_security_group_ids = [module.my_sg.public_sg_prod]
  user_data              = file("../pipeline/pipeline.sh")
  iam_instance_profile   = module.my_iam_profile.testiamprofile
}