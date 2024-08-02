# Simple EKS terraform

## Requisites
Create an Access and Secret Access key from AWS Service and set them as environment variables:

```
export AWS_ACCESS_KEY_ID=XYZ
export AWS_SECRET_ACCESS_KEY=XYZ
export AWS_DEFAULT_REGION=us-east-1
```

Optional
* Install aws cli

## Steps to build an EKS cluster
Modify the terraform.tfvars file according to your needs, it will create a VPC and some subnets, one can interconnect the rest of your systems afterwards.

```
terraform init
terraform apply
```