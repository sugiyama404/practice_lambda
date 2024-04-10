terraform {
  required_version = "=1.0.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# IAM
module "iam" {
  source   = "./modules/iam"
  app_name = var.app_name
}

# network
module "network" {
  source   = "./modules/network"
  app_name = var.app_name
  db_ports = var.db_ports
}

# rds
module "rds" {
  source           = "./modules/rds"
  db_sbg_name      = module.network.db_sbg_name
  sg_rds_source_id = module.network.sg_rds_source_id
  sg_rds_target_id = module.network.sg_rds_target_id
  db_ports         = var.db_ports
  app_name         = var.app_name
  db_name          = var.db_name
  db_username      = var.db_username
  db_password      = var.db_password
}

module "lambda" {
  source          = "./modules/lambda"
  iam_role_lambda = module.iam.iam_role_lambda
  app_name        = var.app_name
  db_address      = module.rds.db_address
  db_name         = var.db_name
  db_username     = var.db_username
  db_password     = var.db_password
}

module "apigateway" {
  source            = "./modules/apigateway"
  lambda_invoke_arn = module.lambda.lambda_invoke_arn
}

module "s3" {
  source   = "./modules/s3"
  app_name = var.app_name
}
