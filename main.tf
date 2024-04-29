module "vpc" {
  source = "./modules/vpc"
}

module "s3" {
  source = "./modules/s3"
}

module "dynamoDB" {
  source = "./modules/dynamoDB"
}