resource "aws_elasticache_cluster" "ec-redis" {
  subnet_group_name    = aws_elasticache_subnet_group.cashe-sub-g.name
  security_group_ids   = [aws_security_group.db-sg.id]
  cluster_id           = "ec-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  engine_version       = "3.2.10"
  port                 = 6379

}