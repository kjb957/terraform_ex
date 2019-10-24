############################################################################
resource "aws_instance" "jumpbox" {
  ami           = "${var.ami_id}"
  instance_type = "${var.ec2_instance_type}"
  key_name      = "${var.ec2_key}"
  #vpc_security_group_ids = ["${aws_security_group.public_jumbox.id}"]
  vpc_security_group_ids = ["${var.ec2_sg_id}"]
  #subnet_id = "${aws_subnet.public_subnet_1.id}"
  subnet_id = "${var.ec2_subnet_id}"
  #user_data = "${file("provision_jumpbox.sh")}"
 
  tags = {
    Name = "${var.vpc_name}-Jumpbox"
  }
}
