variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "eu-west-1"
}
variable "tags" {
  description = "A map of tags to add to all the resources"
  type        = map(string)
  default = {
    environment = "Development"
  }
}
variable "environment" {
  description = "The environment the VPC will be provisioned in"
  type        = string
  default     = "development"
}
variable "s3_logging_bucket" {
  description = "S3 bucket to store VPC logs"
  type        = string
}
####### VPC#####
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "availability_zones" {
  description = "The availability zones to be used"
  type        = list(string)
}
variable "public_subnets" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
}
variable "public_subnets_ids" {
  type        = list(string)
  description = "List of public subnet IDs for the container"
}

###ECS####

variable "cluster_name" {
  type        = string
  description = "Name of the ECS cluster"
}

variable "container_name" {
  type        = string
  description = "Container name"
}

variable "container_image" {
  type        = string
  description = "Image to use in ECS"
}

variable "container_port" {
  type        = number
  description = "Port container exposes"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

####ALB####

variable "loadbalancer_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "loadbalancer_internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}

variable "loadbalancer_type" {
  description = "The type of load balancer (application or network)"
  type        = string
  default     = "application"
}

variable "loadbalancer_subnets" {
  description = "List of public subnet IDs for the load balancer"
  type        = list(string)
}

variable "loadbalancer_enable_deletion_protection" {
  description = "Whether to enable deletion protection on the load balancer"
  type        = bool
  default     = false
}

variable "loadbalancer_listener_default_action_type" {
  description = "The default action type for listeners (e.g., 'forward')"
  type        = string
  default     = "forward"
}

# variable "certificate_arn" {
#   description = "ARN of the ACM certificate for HTTPS listener"
#   type        = string
# }

####R53_DNS####

variable "hosted_zone_id" {
  description = "Route 53 hosted zone ID"
  type        = string
}

variable "alb_dns" {
  description = "ALB DNS name to point to"
  type        = string
}

variable "alb_zone_id" {
  description = "ALB hosted zone ID"
  type        = string
}