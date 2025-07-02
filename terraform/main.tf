module "vpc" {
  source             = "./modules/vpc" //relative path basd on location of the calling module main.tf 
  aws_region         = var.aws_region
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
  tags               = var.tags
  s3_logging_bucket  = var.s3_logging_bucket
  environment        = var.environment
  public_subnets_ids = var.public_subnets_ids
}

module "ecs" {
  source = "./modules/ecs"

  cluster_name    = var.cluster_name
  container_name  = var.container_name
  container_image = var.container_image
  container_port  = var.container_port

  vpc_id             = var.vpc_id
  public_subnets_ids = var.public_subnets_ids

  tags = {
    Environment = var.environment
  }
}

module "alb" {
  source                                    = "./modules/alb"
  loadbalancer_name                         = var.loadbalancer_name
  loadbalancer_internal                     = var.loadbalancer_internal
  loadbalancer_type                         = var.loadbalancer_type
  loadbalancer_subnets                      = var.loadbalancer_subnets
  loadbalancer_enable_deletion_protection   = var.loadbalancer_enable_deletion_protection
  loadbalancer_listener_default_action_type = var.loadbalancer_listener_default_action_type
  environment                               = var.environment
}


# module "ecr" {
#   source = "./modules/ecr"
#   name   = "ecs-repo"
#   tags   = var.tags
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