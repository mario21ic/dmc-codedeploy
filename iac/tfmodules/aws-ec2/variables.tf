variable "region" {
  description = "aws region"
  default     = "us-west-2"
}

variable "env" {
  default = "draft"
  description = "Environment name"
}

variable "name" {
  description = "Name ec2"
}

variable "key_name" {
  description = "key pair name"
}
variable "ami_id" {
  description = "ami id"
}

variable "instance_profile" {
}

variable "ec2_filter_value" {
  description = "Name"
}

