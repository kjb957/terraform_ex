output "public_subnet_1" {
  value = "${aws_subnet.public_subnet_1.id}"
}

output "public_jumbox_sg_id" {
  value = "${aws_security_group.public_jumbox.id}"
}