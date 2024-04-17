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
  db_ports         = var.db_ports
  app_name         = var.app_name
  db_name          = var.db_name
  db_username      = var.db_username
  db_password      = var.db_password
}

# lambda
module "lambda" {
  source                      = "./modules/lambda"
  iam_role_lambda             = module.iam.iam_role_lambda
  app_name                    = var.app_name
  db_address                  = module.rds.db_address
  db_name                     = var.db_name
  db_username                 = var.db_username
  db_password                 = var.db_password
  sg_lambda_id                = module.network.sg_lambda_id
  subnet_private_subnet_1a_id = module.network.subnet_private_subnet_1a_id
  subnet_public_subnet_1a_id  = module.network.subnet_public_subnet_1a_id
  api_execution_arn           = module.apigateway.api_execution_arn
}

# s3
module "s3" {
  source   = "./modules/s3"
  app_name = var.app_name
  region   = var.region
}

# apigateway
module "apigateway" {
  source            = "./modules/apigateway"
  lambda_invoke_arn = module.lambda.lambda_invoke_arn
  iam_role_lambda   = module.iam.iam_role_lambda
  s3_uri            = module.s3.s3_uri
  s3_url            = module.s3.s3_url
  region            = var.region
  app_name          = var.app_name
}
