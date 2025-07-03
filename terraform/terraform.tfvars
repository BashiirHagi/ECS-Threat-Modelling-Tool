aws_region = "eu-west-2"

tags = {
  environment = "Development"
}

environment = "development" //

s3_logging_bucket = "my-vpc-logging-bucket"

//VPC ID
vpc_id = "vpc-0e032919a3130612d"

vpc_cidr = "192.168.0.0/16"

availability_zones = [
  "eu-west-2a",
  "eu-west-2b",
  "eu-west-2c"
]

public_subnets = [
  "192.168.128.0/20",
  "192.168.144.0/20" //
]

# private_subnets = [
#   "192.168.160.0/20",
#   "192.168.176.0/20",
#   "192.168.192.0/20",
#   "192.168.208.0/20"
# ]

public_subnets_ids = [
  "subnet-0bc3d41fd370f01bf",
  "subnet-030ea8a3825c4218e"
]

//ECS

cluster_name = "ecs-threat-model-cluster"

container_name = "nodejs_app"

container_image = "node:18-alpine" # alpline linux image 

container_port = 3000 // SG port for node.js app 


//ALB

loadbalancer_name = "ecs-threat-model-alb"

loadbalancer_internal = false

loadbalancer_type = "application"

loadbalancer_subnets = [
  "subnet-0bc3d41fd370f01bf",
  "subnet-030ea8a3825c4218e"
]

loadbalancer_enable_deletion_protection = true

loadbalancer_listener_default_action_type = "forward" //

certificate_arn = "arn:aws:acm:eu-west-2:111045647844:certificate/c30c5a3f-ef4b-4889-aead-f714428badab"


///R53_DNS

hosted_zone_id = "Z0944981H4XKCCLC0YVX"

alb_dns = "ecs-threat-model-alb-614146528.eu-west-2.elb.amazonaws.com"

alb_zone_id = "ZHURV8PSTC4K8"


//ECR

ecr_name = "threat-model-app"

image_tag_mutability = "MUTABLE"







