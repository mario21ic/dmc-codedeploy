variable "aws_region" {
  type    = string
  default = "us-west-2"
}

data "amazon-ami" "ubuntu" {
  filters = {
    architecture        = "x86_64"
    "block-device-mapping.volume-type" = "gp2"
    name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["099720109477"]
  region      = var.aws_region
}

source "amazon-ebs" "jenkins" {
  ami_name      = "devops_jenkins {{ timestamp }}"
  encrypt_boot  = false
  instance_type = "t2.micro"
  region        = "${var.aws_region}"
  source_ami    = data.amazon-ami.ubuntu.id
  ssh_username  = "ubuntu"
}

build {
  name    = "devops_jenkins"
  sources = [
    "sources.amazon-ebs.jenkins"
  ]

  provisioner "shell" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -sSL https://get.docker.com | sudo sh",
      "sudo usermod -aG docker ubuntu",
      "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-11-jre",
      "sudo apt-get install -y jenkins",
      "sudo usermod -aG docker jenkins",
      "sudo systemctl restart jenkins",
      "sudo systemctl enable jenkins",
      "echo JENKINS PASSWORD",
      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
    ]
  }

}

