resource "aws_eks_access_entry" "bastion" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = "arn:aws:iam::213265226678:role/Bastion-role"
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "bastion_admin" {
  cluster_name  = aws_eks_cluster.cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_eks_access_entry.bastion.principal_arn
  access_scope {
    type = "cluster"
  }
}


resource "aws_eks_access_entry" "root_user" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = "arn:aws:iam::213265226678:root"
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "root_admin" {
  cluster_name  = aws_eks_cluster.cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_eks_access_entry.root_user.principal_arn
  access_scope {
    type = "cluster"
  }
}
