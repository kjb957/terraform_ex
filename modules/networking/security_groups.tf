resource "aws_security_group" "public_jumbox" {
  name        = "${var.vpc_name}-jb-SG"
  description = "Allow ssh inbound traffic"
  vpc_id      = "${aws_vpc.infrastructure_vpc.id}"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["${var.my_ip_address}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["${var.vpc_default_route}"]
  }

  tags = {
    Name = "Allow 22"
  }
}

############################################################################