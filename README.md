# AWS Prime Video Infrastructure

This repository contains Terraform code to provision AWS infrastructure for a Prime Video-like application.

## Architecture Overview

The infrastructure includes:
- **VPC** with public and private subnets across 2 availability zones
- **EC2 instances** in both public and private subnets
- **ECS cluster** with Fargate service for containerized applications
- **Internet Gateway** and **NAT Gateway** for proper networking
- **Security Groups** with appropriate access controls
- **Auto-generated SSH key pair** for EC2 access

## Components

### Networking (vpc.tf)
- VPC with DNS support enabled
- 2 public subnets and 2 private subnets
- Internet Gateway for public subnet internet access
- NAT Gateway for private subnet outbound internet access
- Route tables and associations
- Security groups for public and private resources

### Compute (ec2.tf)
- 2 public EC2 instances with web servers
- 2 private EC2 instances
- 1 dedicated Prime Video instance
- Auto-generated key pair for SSH access

### Container Services (ecs.tf)
- ECS cluster with container insights enabled
- Fargate task definition running nginx
- ECS service with desired count of 1
- CloudWatch log group for container logs
- IAM roles for ECS task execution

## Files Structure

```
├── main.tf           # Provider configuration and key pair generation
├── variables.tf      # Input variables definition
├── outputs.tf        # Output values
├── versions.tf       # Terraform and provider version constraints
├── vpc.tf           # VPC, subnets, gateways, and networking
├── ec2.tf           # EC2 instances and AMI data sources
├── ecs.tf           # ECS cluster, task definition, and service
└── terraform.tfvars # Variable values
```

## Prerequisites

1. **AWS CLI** configured with appropriate credentials
2. **Terraform** >= 1.0.0 installed
3. Appropriate **AWS permissions** to create VPC, EC2, ECS, and IAM resources

## Usage

### 1. Clone the repository
```bash
git clone https://github.com/iam-chaitu/aws-prime-terraform.git
cd aws-prime-terraform
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Review the plan
```bash
terraform plan
```

### 4. Apply the configuration
```bash
terraform apply
```

### 5. Access your resources
After successful deployment:
- Public instance IPs will be displayed in outputs
- SSH key (`prime.pem`) will be generated locally
- ECS service will be running in private subnets

### 6. Clean up
```bash
terraform destroy
```

## Configuration

You can customize the deployment by modifying `terraform.tfvars`:

```hcl
aws_region           = "us-east-1"              # AWS region
vpc_cidr             = "10.0.0.0/16"           # VPC CIDR block
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]   # Public subnet CIDRs
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]   # Private subnet CIDRs
availability_zones   = ["us-east-1a", "us-east-1b"]     # AZs to use
instance_type        = "t2.micro"              # EC2 instance type
```

## Outputs

The following outputs are available:
- `vpc_id` - The ID of the created VPC
- `public_subnet_ids` - IDs of public subnets
- `private_subnet_ids` - IDs of private subnets
- `public_instance_ips` - Public IP addresses of public instances
- `private_instance_ids` - IDs of private instances
- `prime_video_instance_ip` - Public IP of the Prime Video instance
- `ecs_cluster_name` - Name of the ECS cluster
- `ecs_service_name` - Name of the ECS service

## Security Considerations

- **SSH access** is restricted to public instances only
- **Private instances** can only be accessed from public instances
- **ECS service** runs in private subnets for enhanced security
- **Security groups** follow principle of least privilege
- **SSH key** is auto-generated and stored locally

## Cost Optimization

- Uses **t2.micro** instances (eligible for free tier)
- **ECS Fargate** with minimal resource allocation
- **Single NAT Gateway** to reduce costs

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is licensed under the MIT License.
