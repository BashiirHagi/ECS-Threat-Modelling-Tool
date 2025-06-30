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
####### VPC######################
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

//ECS

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
