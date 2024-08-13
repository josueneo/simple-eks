region           = "us-east-1"
k8s_cluster_name = "simplecluster"
k8s_version      = "1.30"
k8s_tags         = {}
#Example
#k8s_tags =  {
#    cost_center = "243221"
#  }
#Optional, it requires aws cli installed
#create_kubeconfig = 1
#k8s_kubeconfig = "/Users/josue/.kube/config"

#Comment the vpc_id variable if you wish to create a new VPC, or set the id if you want to reuse one.
vpc_id = "vpc-xyz"
#Needed when creating a new VPC, uncomment if the vpc_id variable is commented.
#vpc_name       = "simpleclustervpc"
#vpc_cidr       = "10.20.0.0/22"
#vpc_azs        = ["us-east-1a", "us-east-1b"]

#Adjust the subnets according to your VPC CIDR (network address)
#IF reusing a VPC subnet_private should have a list of subnet IDs
#A minimum of 2 subnets within different availability zones
subnet_private = ["subnet-xyz", "subnet-zyx"]
#If creating a VPC specify the CIDR as below and comment line above
#subnet_private = ["10.20.0.0/25", "10.20.1.0/25"]