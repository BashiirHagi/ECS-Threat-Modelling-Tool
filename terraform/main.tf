module "vpc" {
  source             = "./modules/vpc" //relative path basd on location of the calling module main.tf 
  aws_region         = var.aws_region
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
  tags               = var.tags
  s3_logging_bucket  = var.s3_logging_bucket
  environment        = var.environment
}

module "ecs" {
  source = "./modules/ecs"

  cluster_name    = var.cluster_name
  container_name  = var.container_name
  container_image = var.container_image
  container_port  = var.container_port

  vpc_id          = var.vpc_id
  public_subnets_ids = var.private_subnets_ids

  tags = {
    Environment = var.environment
  }
}

//root module and calling module - child module and calling module 

# module "ecr" {
#   source = "./modules/ecr"
#   name   = "ecs-repo"
#   tags   = var.tags
# }

# module "ecs" {
#   source             = "./modules/ecs"
#   cluster_name       = "ecs-cluster"
#   vpc_id             = module.vpc.vpc_id
#   private_subnets    = module.vpc.private_subnet_ids
#   ecr_repo_url       = module.ecr.repository_url
#   tags               = var.tags
# }

# module "elb" {
#   source             = "./modules/elb"
#   vpc_id             = module.vpc.vpc_id
#   public_subnets     = module.vpc.public_subnet_ids
#   target_group_port  = 80
#   tags               = var.tags
# }

# module "rds" {
#   source             = "./modules/rds"
#   vpc_id             = module.vpc.vpc_id
#   private_subnets    = module.vpc.private_subnet_ids
#   db_name            = var.db_name
#   db_username        = var.db_username
#   db_password        = var.db_password
#   tags               = var.tags
# }