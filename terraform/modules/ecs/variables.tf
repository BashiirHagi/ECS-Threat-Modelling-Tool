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

# variable "private_subnets_ids" {
#   type        = list(string)
#   description = "List of private subnet IDs for the container"
# }

variable "public_subnets_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the container"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
}