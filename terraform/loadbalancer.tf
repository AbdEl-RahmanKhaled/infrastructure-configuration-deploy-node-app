resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [module.network.pub_sub-1_id, module.network.pub_sub-2_id]
  
  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "app_lb_lestener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_lb_tg.arn
  }
}