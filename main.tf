module "network" {
    source = "./network"
    
    ws_name = var.ws_name
    region = var.region
    vpc_name = var.vpc_name
    vpc_cidr_block = var.vpc_cidr_block
    pub_sub-1_cidr_block = var.pub_sub-1_cidr_block
    pub_sub-2_cidr_block = var.pub_sub-2_cidr_block
    priv_sub-1_cidr_block = var.priv_sub-1_cidr_block
    priv_sub-2_cidr_block = var.priv_sub-2_cidr_block
}