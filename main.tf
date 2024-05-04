module "vpc" {
  source = "./modules/vpc"
}

module "s3" {
  source = "./modules/s3"
  lambda_func_arn = module.lambda.lambda_func_arn
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
  event_rule = module.eventbridge.event_rule_arn
  bucket_arn = module.s3.bucket_arn
}

module "eventbridge" {
  source = "./modules/eventbridge"
  lambda_func_arn = module.lambda.lambda_func_arn
  bucket_name = module.s3.s3_bucket
}