# terraform {
#   backend "s3" {
#     bucket         = "tf-state-ecs101"         
#     key            = "env/dev/terraform.tfstate"  
#     region         = "eu-west-2"
#     dynamodb_table = "tf-lock-table"            
#     encrypt        = true
#   }
# }