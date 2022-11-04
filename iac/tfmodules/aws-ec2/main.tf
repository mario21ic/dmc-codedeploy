locals {
  //command = "aws ssm start-session --target ${aws_instance.proxy.id} --region ${var.region}"
  name_prefix = "${var.env}-${var.name}"
}

/*
data "aws_ami" "amazonv2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}
*/

resource "aws_instance" "ec2_draft" {
  //ami                    = "${data.aws_ami.amazonv2.id}"
  ami                    = "${var.ami_id}"
  instance_type          = "t2.nano"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.sg_draft.id}"]
  associate_public_ip_address = true
  //iam_instance_profile = "${aws_iam_instance_profile.instance_profile.id}"
  iam_instance_profile = "${var.instance_profile}"

  #count = 3
  count = 1

  tags = {
    Name        = "${local.name_prefix}-deploy-ec2"
    cd_ec2_tag  = var.ec2_filter_value
    Enviroment  = "${var.env}"
    Description = "Server application"
  }

  // Install nginx and aws codedeploy
  /*
  connection {
      host      = self.public_ip
      user      = "ec2-user"
      type      = "ssh"
      //private_key = "${file("${var.key_name}")}"
      //private_key = file("./Alo2.pem")
      //private_key = file("${path.root}/Alo2.pem")
      private_key = file("${path.root}/${var.key_name}.pem")
      timeout   = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo yum install ruby wget -y",
      "wget https://aws-codedeploy-us-east-2.s3.us-east-2.amazonaws.com/latest/install",
      "chmod +x install",
      "sudo ./install auto",
      "sudo amazon-linux-extras install nginx1 -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "sudo yum install docker -y",
      "sudo pip3 install docker-compose",
      "sudo usermod -aG docker ec2-user",
      "sudo systemctl start docker",
      "sudo systemctl enable docker"
    ]
  }
  */
}

resource "aws_security_group" "sg_draft" {
  name        = "${local.name_prefix}-deploy-sg"
  description = "Server application inbound and outbound"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Enviroment  = "${var.env}"
    Description = "Server application security group"
  }
}

