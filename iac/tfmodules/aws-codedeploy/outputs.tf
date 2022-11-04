output "codedeploy_app_id" {
  value = "${aws_codedeploy_app.cd_app.id}"
}
output "codedeploy_app_name" {
  value = "${aws_codedeploy_app.cd_app.name}"
}

output "codedeploy_group_id" {
  value = "${aws_codedeploy_deployment_group.cd_app_group.id}"
}
output "codedeploy_group_name" {
  value = "${aws_codedeploy_deployment_group.cd_app_group.deployment_group_name}"
}

output "codedeploy_role_name" {
  value = "${aws_iam_role.cd_role.name}"
}
output "codedeploy_policy_name" {
  value = "${aws_iam_role_policy.codedeploy_policy.name}"
}


output "ec2_instance_profile_id" {
  value = "${aws_iam_instance_profile.instance_profile.id}"
}

output "ec2_instance_policy_name" {
  value = "${aws_iam_role_policy.ec2_instance_policy.name}"
}

