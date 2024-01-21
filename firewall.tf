# Resource-10: Create Security Group
resource "aws_security_group" "ecomm-sg" {
  name        = "Ecomm SSH & HTTP"
  description = "Allow SSH & HTTP inbound traffic"
  vpc_id      = aws_vpc.ecomm-vpc.id

  ingress {
    description = "Allow SSH from port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP from port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all IP and Ports Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Ecomm-SG"
  }
}
