resource "aws_lb_target_group" "app_lb_tg" {
  name     = "app-lb-tg"
  port     = 3000
  protocol = "TCP"
  vpc_id   = module.network.vpc_id
}

resource "aws_lb_target_group_attachment" "app_lb_tg_att" {
  target_group_arn = aws_lb_target_group.app_lb_tg.arn
  target_id        = aws_instance.priv-ec2.id
  port             = 3000
}