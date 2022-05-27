variable "eks_sub_1" {
  type = string
}

variable "eks_sub_2" {
  type = string
}

variable "ws_name" {
  type = string
  description = "Workspace name"  
}

variable "nodes_desired_size" {
  type = number
}

variable "nodes_max_size" {
  type = number
}

variable "nodes_min_size" {
  type = number
}

