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

module "eks" {
    source = "./eks"

    ws_name = var.ws_name
    eks_sub_1 = module.network.pri_sub-1_id
    eks_sub_2 = module.network.pri_sub-2_id

    nodes_desired_size = var.nodes_desired_size
    nodes_max_size = var.nodes_max_size
    nodes_min_size = var.nodes_min_size

    sg_cidr = var.vpc_cidr_block
    vpc_id = module.network.vpc_id

}