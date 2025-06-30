resource "aws_vpc" "vpc_ecs" {  
  cidr_block = var.vpc_cidr 
  tags = {
    Name = "${var.environment}-vpc"
    Environment = var.environment
  }
}
resource "aws_subnet" "public_subnet" { 
  for_each          = { for index, cidr in var.public_subnets : index => cidr } 
  vpc_id            = aws_vpc.vpc_ecs.id
  availability_zone = element(var.availability_zones, each.key)
  cidr_block        = each.value
  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-public-subnet-${each.key}", //each-key - 
    }
  )
}
# resource "aws_subnet" "private_subnet" {
#   for_each          = { for index, cidr in var.public_subnets : index => cidr } //
#   vpc_id            = aws_vpc.vpc_ecs.id
#   availability_zone = element(var.availability_zones, each.key)
#   cidr_block        = each.value
#   tags = merge(
#     var.tags,
#     {
#       Name = "${var.environment}-private-subnet-${each.key}",
#     }
#   )
# }
## public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_ecs.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.environment}-public-rt"
  }
}
## route table association - public
resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public_subnet //for each argument 
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}
# ## private route table
# resource "aws_route_table" "private_route_table" { //will use later, private + NAT + ALB
#   vpc_id = aws_vpc.vpc_ecs.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     //gateway_id = aws_nat_gateway.nat_gateway.id
#   }
#   tags = {
#     Name = "${var.environment}-private-rt"
#   }
# }

# ## route table association - private
# resource "aws_route_table_association" "private_route_table" {
#   for_each       = aws_subnet.private_subnet //for each argument 
#   subnet_id      = each.value.id
#   route_table_id = aws_route_table.private_route_table.id
# }
resource "aws_eip" "eip" { //
  //dovpc_ecs = "vpc"
  tags = {
    Name = "${var.environment}-eip"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_ecs.id
  tags = {
    Name = "${var.environment}-internet-gateway"
  }
}

# resource "aws_nat_gateway" "nat_gateway" {
#   connectivity_type = "public"
#   subnet_id         = aws_subnet.public_subnet[0].id //first item in the subnet_id list using [0]
#   allocation_id     = aws_eip.eip.id
#   depends_on        = [aws_internet_gateway.igw]
#   tags = {
#     Name = "${var.environment}-nat-gateway"
#   }
# }

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.vpc_ecs.id
  //ervice_name      = "com.amazonaws.${var.aws_region}.s3"
  service_name = "com.amazonaws.eu-west-2.s3"
  vpc_endpoint_type = "Gateway" //2 types - gateway and 
  tags = {
    Name = "${var.environment}-vpc-endpoint"
  }
}
###VPC Flow logs + S3 storage 
resource "aws_s3_bucket" "logging" { 
  bucket = var.s3_logging_bucket
  tags = {
    Name = "${var.environment}-bucket"
  }
}
resource "aws_flow_log" "flow_log" {
  vpc_id               = aws_vpc.vpc_ecs.id
  log_destination      = aws_s3_bucket.logging.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  tags = {
    Name = "${var.environment}-flow-log"
  }
}