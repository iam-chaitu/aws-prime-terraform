output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.prime_vpc.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private_subnets[*].id
}

output "public_instance_ips" {
  description = "The public IPs of the public instances"
  value       = aws_instance.public_instances[*].public_ip
}

output "private_instance_ids" {
  description = "The IDs of the private instances"
  value       = aws_instance.private_instances[*].id
}

output "prime_video_instance_ip" {
  description = "The public IP of the Prime Video instance"
  value       = aws_instance.prime_video_instance.public_ip
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.prime_video.name
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.prime_video_service.name
}
