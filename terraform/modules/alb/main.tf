resource "aws_lb" "load_balancer" {
  name                       = var.loadbalancer_name
  internal                   = var.loadbalancer_internal
  load_balancer_type         = var.loadbalancer_type
  security_groups            = [aws_security_group.sg.id]
  subnets                    = var.loadbalancer_subnets
  enable_deletion_protection = var.loadbalancer_enable_deletion_protection

  tags = {
    Name = "${var.environment}-lb"
  }
}

#########load-balancers listeners#######
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = var.loadbalancer_listener_default_action_type
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
  tags = {
    Name = "${var.environment}-http-listener"
  }
}

# resource "aws_lb_listener" "https_listener" {
#   load_balancer_arn = aws_lb.load_balancer.arn
#   port              = 443
#   protocol          = "HTTPS"
#   certificate_arn   = var.certificate_arn

#   default_action {
#     type             = var.loadbalancer_listener_default_action_type
#     target_group_arn = aws_lb_target_group.alb_target_group.arn
#   }
#   tags = {
#     Name = "${var.environment}-https-listener"
#   }
# }