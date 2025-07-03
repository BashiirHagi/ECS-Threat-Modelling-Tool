resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
  tags = var.tags
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.container_name
  requires_compatibilities = ["FARGATE"] //fargate launch type 
  network_mode            = "awsvpc"
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn      = aws_iam_role.ecs_task_exec.arn
  container_definitions   = jsonencode([
    {
      name      = var.container_name
      image     = "bashiir95/node-js-app:latest"
      portMappings = [{
        containerPort = var.container_port
        protocol      = "tcp"
      }]
    }
  ])
}

resource "aws_ecs_service" "this" { //
  name            = "${var.container_name}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  desired_count   = 4 //ECS tasks for HA

  network_configuration {
    subnets         = var.public_subnets_ids 
    assign_public_ip = true //public access for ecs tasks with public IP
    security_groups  = [aws_security_group.ecs_tasks.id] //
  } 

  load_balancer { 
    target_group_arn = var.target_group_arn // ALB target for ecs service group arn
    container_name   = var.container_name 
    container_port   = 3000
  }

  depends_on = [aws_ecs_cluster.this]
}

resource "aws_security_group" "ecs_tasks" { 
  name   = "${var.container_name}-sg" //
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] //all traffic allowed for ingress traffic on port 3000
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_iam_role" "ecs_task_exec" {
  name = "${var.container_name}-task-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_exec_attach" {
  role       = aws_iam_role.ecs_task_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}