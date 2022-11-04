variable "region" {
  description = "aws region"
  default     = "us-west-2"
}

variable "env" {
  default = "draft"
  description = "Environment name"
}

variable "name" {
  description = "Name codedeploy"
}

variable "ec2_filter_value" {
  description = "Name"
}

