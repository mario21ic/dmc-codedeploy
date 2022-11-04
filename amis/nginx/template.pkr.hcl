variable "aws_region" {
  type    = string
  default = "us-west-2"
}


data "amazon-ami" "amazonv2" {
  filters = {
    architecture        = "x86_64"
    "block-device-mapping.volume-type" = "gp2"
    name                = "amzn2-ami-hvm*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  //owners      = ["099720109477"]
  owners = ["amazon"]
  region      = var.aws_region
}

source "amazon-ebs" "nginx" {
  ami_name      = "devops_nginx {{ timestamp }}"
  encrypt_boot  = false
  instance_type = "t2.micro"
  region        = "${var.aws_region}"
  source_ami    = data.amazon-ami.amazonv2.id
  ssh_username  = "ec2-user"
}

build {
  name    = "devops_nginx"
  sources = [
    "sources.amazon-ebs.nginx"
  ]

  provisioner "shell" {
    inline = [
      "sudo yum install ruby wget -y",
      "wget https://aws-codedeploy-us-west-2.s3.us-west-2.amazonaws.com/latest/install",
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

}

