# IAM

Policies for `banking-tools-server-role`, the role attached to the tools server.

| File | Type | Purpose |
|---|---|---|
| ec2-trust-policy.json | Trust policy | Only the EC2 service can use the role |
| terraform-vpc-mumbai.json | Permissions | Create and delete VPC networking, ap-south-1 only |
| terraform-state-bucket-access.json | Permissions | Read and write the Terraform state bucket only |

The role cannot change IAM itself. Policy changes are made in the AWS
console by an administrator and recorded here through a pull request.
