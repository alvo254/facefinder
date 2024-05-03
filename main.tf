module "vpc" {
  source = "./modules/vpc"
}

module "s3" {
  source = "./modules/s3"
}

module "dynamoDB" {
  source = "./modules/dynamoDB"
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "lambda" {
  source = "./modules/lambda"
  bucket_name = module.s3.s3_bucket
  subnet_id = module.vpc.public_subnet
  security_group = module.sg.security_group_ids
}