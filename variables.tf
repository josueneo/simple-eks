variable "create_kubeconfig" {
  description = "Set to 1 if you want to create a .kube/config file for your cluster"
  default     = 0
}
variable "vpc_id" {
  description = "IF reusing a vpc, set the id here"
  type        = string
  default     = null
}
variable "region" {
  description = "Region to deploy resources"
  default     = "us-east-1"
}

variable "k8s_cluster_name" {
  description = "Name of the EKS cluster"
  default     = "eks"
}

variable "k8s_version" {
  description = "K8S version to deploy"
  default     = "1.30"
}

variable "k8s_tags" {
  description = "Tags to add to the AWS Resource"
  default     = {}
}

variable "k8s_kubeconfig" {
  description = "Name of the kubeconfig to create"
  default     = ".eks-config"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "vpc-demo"
}

variable "vpc_cidr" {
  description = "Network segment"
  default     = "10.20.0.0/22"
}

variable "vpc_azs" {
  description = "Availability zones"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "subnet_private" {
  description = "Segment for private space"
  default     = ["10.20.0.0/25", "10.20.1.0/25"]
}