module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~>20.0"

  cluster_name                   = var.k8s_cluster_name
  cluster_version                = var.k8s_version
  tags                           = var.k8s_tags
  cluster_endpoint_public_access = true
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets

  access_entries = {
    # One access entry with a policy associated
    access_for_josue = {
      kubernetes_groups = []
      principal_arn     = "${data.aws_caller_identity.current.arn}"

      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  eks_managed_node_groups = {
    nodes = {
      instance_types = ["t3.medium"] #<---- decide which type
      min_size       = 1
      max_size       = 4
      desired_size   = 3
    }
  }

}

resource "null_resource" "kubeconfig" {
  count = var.create_kubeconfig
  depends_on = [module.eks]
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
      set -e
      echo 'Creating kubeconfig file...'
      aws eks wait cluster-active --name '${module.eks.cluster_name}'
      aws eks update-kubeconfig --name '${module.eks.cluster_name}' --alias '${module.eks.cluster_name}-${var.region}' --region=${var.region} --kubeconfig ${var.k8s_kubeconfig}
    EOT
  }
}

module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.12"

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn

  depends_on = [aws_iam_role.AmazonEKS_EBS_CSI_DriverRole]

  eks_addons = {
    kube-proxy             = {}
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
    aws-ebs-csi-driver = {
      service_account_role_arn = "${aws_iam_role.AmazonEKS_EBS_CSI_DriverRole.arn}"
    }
  }
}