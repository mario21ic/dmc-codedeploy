resource "aws_iam_instance_profile" "instance_profile" {
  name  = "${local.name_prefix}-ec2-cd"
  role = "${aws_iam_role.instance_role.name}"
}


data "aws_iam_policy_document" "ec2_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance_role" {
  name = "${local.name_prefix}-instance-role"

//  assume_role_policy = <<EOF
//{
//  "Version": "2008-10-17",
//  "Statement": [
//    {
//      "Effect": "Allow",
//      "Principal": {
//        "Service": "ec2.amazonaws.com"
//      },
//      "Action": "sts:AssumeRole"
//    }
//  ]
//}
//EOF

  assume_role_policy = "${data.aws_iam_policy_document.ec2_policy_document.json}"
}

data "aws_iam_policy_document" "codedeploy_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cd_role" {
  name = "${local.name_prefix}-cd-role"
//
//  assume_role_policy = <<EOF
//{
//  "Version": "2008-10-17",
//  "Statement": [
//    {
//      "Sid": "1",
//      "Effect": "Allow",
//      "Principal": {
//        "Service": "codedeploy.amazonaws.com"
//      },
//      "Action": "sts:AssumeRole"
//    }
//  ]
//}
//EOF

  assume_role_policy = "${data.aws_iam_policy_document.codedeploy_policy_document.json}"
}
