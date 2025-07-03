# ECS-Threat-Modelling-Tool

This project deploys a containerized Node.js web application on an AWS Elastic Container Service (ECS). The infrastructure is fully managed through Terraform modules, and deployments are automated through a GitHub Actions CI/CD pipeline. 

The entire architecture is designed for high availability, scalability and security which is ideal for modern cloud-native applications. 

## Key components include:
	- ECS (Fargate) – for running containers without managing servers
	- ECR – to store Docker container images
	- Application Load Balancer (ALB) – for distributing traffic across ECS tasks
	- Route 53 + ACM – to route traffic and enable HTTPS with custom domain
	- Terraform – for IaC (Infrastructure as Code) using modular design
	- GitHub Actions – for automated provisioning and deployments
	- S3 + DynamoDB – as Terraform remote backend and state lock management

## Project Structure:

```bash

ECS-Threat-Modelling-Tool/
├── app/                           # Node.js application source code
│   └── ...                        # App logic, routes, package.json etc.
│
├── terraform/                     # Infrastructure as Code (IaC) root folder
│   ├── backend.tf                 # Terraform backend configuration (S3 + DynamoDB)
│   ├── main.tf                    # Root Terraform configuration
│   ├── variables.tf               # Input variable definitions
│   ├── terraform.tfvars           # Actual variable values (env-specific)
│   └── modules/                   # Reusable Terraform modules
│       ├── alb/                   # Application Load Balancer module
│       ├── ecr/                   # Elastic Container Registry module
│       ├── ecs/                   # ECS service + task definition module
│       ├── r53_dns/               # Route 53 DNS + ACM module
│       └── vpc/                   # VPC, subnets, and networking module
│
├── .github/workflows/            # GitHub Actions CI/CD workflows
│   └── ecs_deploy.yml             # CI/CD pipeline to deploy infra/app
│
├── AWS-architectur.png         # Architecture diagram
├── .gitignore                    # Git ignored files
└── README.md                     # Project overview and instructions
```


![Architecture Diagram](AWS-architecture.png)

AWS Elastic Contaner Service (ECS) - https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html


