resource "aws_db_subnet_group" "main-sub-g" {
  name       = "main-sub-g"
  subnet_ids = [module.network.pri_sub-1_id, module.network.pri_sub-2_id]

  tags = {
    Name = "DB subnet group"
  }
}


resource "aws_elasticache_subnet_group" "cashe-sub-g" {
  name       = "cashe-sub-g"
  subnet_ids = [module.network.pri_sub-1_id, module.network.pri_sub-2_id]
}