# module "vpc" {
#   source             = "./modules/vpc"
#   aws_region         = var.aws_region
#   vpc_cidr           = var.vpc_cidr
#   public_subnets     = var.public_subnets
#   availability_zones = var.availability_zones
#   tags               = var.tags
#   s3_logging_bucket  = var.s3_logging_bucket
#   environment        = var.environment
#   public_subnets_ids = var.public_subnets_ids
# }

# module "ecs" {
#   source           = "./modules/ecs"
#   target_group_arn = module.alb.ecs_target_group_arn
#   cluster_name     = var.cluster_name
#   container_name   = var.container_name
#   container_image  = var.container_image
#   container_port   = var.container_port

#   vpc_id             = var.vpc_id
#   public_subnets_ids = var.public_subnets_ids

#   tags = {
#     Environment = var.environment
#   }
# }

# module "alb" {
#   source                                    = "./modules/alb"
#   vpc_id                                    = var.vpc_id
#   loadbalancer_name                         = var.loadbalancer_name
#   loadbalancer_internal                     = var.loadbalancer_internal
#   loadbalancer_type                         = var.loadbalancer_type
#   loadbalancer_subnets                      = var.loadbalancer_subnets
#   loadbalancer_enable_deletion_protection   = var.loadbalancer_enable_deletion_protection
#   loadbalancer_listener_default_action_type = var.loadbalancer_listener_default_action_type
#   certificate_arn                           = var.certificate_arn
#   environment                               = var.environment
# }


# module "r53_dns" {
#   source         = "./modules/r53_dns"
#   hosted_zone_id = var.hosted_zone_id
#   alb_dns        = var.alb_dns
#   alb_zone_id    = var.alb_zone_id
# }

# module "ecr" {
#   source               = "./modules/ecr"
#   ecr_name             = var.ecr_name
#   image_tag_mutability = var.image_tag_mutability
# }