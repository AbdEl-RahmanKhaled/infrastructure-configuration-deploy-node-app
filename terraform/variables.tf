
variable "ws_name" {
  type = string
  description = "Workspace name"  
}

variable "region" {
  type = string
  description = "Main region"
}


# VPC vars
variable vpc_name {
  type        = string
  description = "vpc name"
}

variable vpc_cidr_block {
  type        = string
  description = "vpc CIDR block"
}

# Subnets vars
variable "pub_sub-1_cidr_block" {
  type = string
  description = "public subnet 1 CIDR"
}

variable "pub_sub-2_cidr_block" {
  type = string
  description = "public subnet 2 CIDR"
}

variable "priv_sub-1_cidr_block" {
  type = string
  description = "private subnet 1 CIDR"
}

variable "priv_sub-2_cidr_block" {
  type = string
  description = "private subnet 2 CIDR"
}

# EC2
variable "ami_id" {
  type = string
  description = "Image id"
}

# rds
variable "rds_username" {
  type = string
}

variable "rds_password" {
  type = string
}

# EKS
variable "nodes_desired_size" {
  type = number
}

variable "nodes_max_size" {
  type = number
}

variable "nodes_min_size" {
  type = number
}