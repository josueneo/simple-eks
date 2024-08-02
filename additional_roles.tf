# Create role
resource "aws_iam_role" "AmazonEKS_EBS_CSI_DriverRole" {
  name = "AmazonEKS_EBS_CSI_DriverRole"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Federated": "${module.eks.oidc_provider_arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa",
          "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:aud": "sts.amazonaws.com"
        }
      }
    }
  ]
}
POLICY

  depends_on = [module.eks]

  tags = {
    "ServiceAccountName"      = "ebs-csi-controller-sa"
    "ServiceAccountNameSpace" = "kube-system"
  }
}

resource "aws_iam_role_policy_attachment" "ebs_csi_attach" {
  role       = aws_iam_role.AmazonEKS_EBS_CSI_DriverRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy" #already exists
  depends_on = [aws_iam_role.AmazonEKS_EBS_CSI_DriverRole]
}

