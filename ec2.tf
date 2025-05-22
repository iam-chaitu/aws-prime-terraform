# AMI Data Source
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Public EC2 instances
resource "aws_instance" "public_instances" {
  count                  = 2
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnets[count.index % length(aws_subnet.public_subnets)].id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name               = aws_key_pair.prime_key_pair.key_name

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>This is a public instance ${count.index + 1}</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name = "prime-public-instance-${count.index + 1}"
  }
}

# Private EC2 instances
resource "aws_instance" "private_instances" {
  count                  = 2
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_subnets[count.index % length(aws_subnet.private_subnets)].id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = aws_key_pair.prime_key_pair.key_name

  tags = {
    Name = "prime-private-instance-${count.index + 1}"
  }
}

# Prime Video EC2 Instance
resource "aws_instance" "prime_video_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnets[0].id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name               = aws_key_pair.prime_key_pair.key_name

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Prime Video Server</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name = "prime-video-instance"
  }
}
