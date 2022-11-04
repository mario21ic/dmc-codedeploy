output "ec2_instance_public_ip" {
  value = "${aws_instance.ec2_draft[0].public_ip}"
}

