resource "aws_eks_cluster" "aws_eks" {
  name     = "${var.ws_name}_eks_cluster"
  role_arn = aws_iam_role.eks_cluster.arn
  
  vpc_config {
    subnet_ids = [var.eks_sub_1, var.eks_sub_2]
    endpoint_private_access = true
  }

  tags = {
    Name = "${var.ws_name}-eks"
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy
  ]
}