locals {
  name_prefix = "${var.env}-${var.name}"
}

resource "aws_codedeploy_app" "cd_app" {
  name = "${local.name_prefix}-cd"
}


resource "aws_codedeploy_deployment_group" "cd_app_group" {
  app_name              = "${aws_codedeploy_app.cd_app.name}"
  deployment_group_name = "${local.name_prefix}-dg"
  service_role_arn      = "${aws_iam_role.cd_role.arn}"
  deployment_config_name = "CodeDeployDefault.OneAtATime"

  ec2_tag_filter {
    //key   = "${var.ec2_filter_key}"
    //key   = "Name"
    key   = "cd_ec2_tag"
    type  = "KEY_AND_VALUE"
    value = "${var.ec2_filter_value}"
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

}
