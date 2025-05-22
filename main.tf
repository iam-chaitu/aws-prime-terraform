provider "aws" {
  region = var.aws_region
}

# Generate key pair for EC2 instance
resource "tls_private_key" "prime_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create the key pair in AWS
resource "aws_key_pair" "prime_key_pair" {
  key_name   = "prime"
  public_key = tls_private_key.prime_key.public_key_openssh
}

# Save the private key locally
resource "local_file" "prime_pem" {
  content         = tls_private_key.prime_key.private_key_pem
  filename        = "${path.module}/prime.pem"
  file_permission = "0400"
}
