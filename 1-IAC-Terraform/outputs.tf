output "eks-creation-status" {
  value = aws_eks_cluster.eks-cluster.status
}

output "external-dns-iam-role" {
  value = aws_iam_role.external-dns.arn
}