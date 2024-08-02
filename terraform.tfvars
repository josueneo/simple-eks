region = "us-east-1"
k8s_cluster_name = "simplecluster"
k8s_version = "1.30"
k8s_tags = {}
#Example
#k8s_tags =  {
#    cost_center = "243221"
#  }
#Optional, it requires aws cli installed
#create_kubeconfig = 1
#k8s_kubeconfig = "/Users/josue/.kube/config"
vpc_name = "simpleclustervpc"
vpc_cidr = "10.20.0.0/22"
vpc_azs = ["us-east-1a", "us-east-1b"]
subnet_private =  ["10.20.0.0/25", "10.20.1.0/25"]
subnet_intra = ["10.20.0.128/25", "10.20.1.128/25"]
subnet_public = ["10.20.2.0/27", "10.20.2.32/27"]

