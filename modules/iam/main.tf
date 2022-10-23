resource "aws_iam_role" "test_role" {
  name = "test_role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
            "Service": "rds.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = {
    tag-key = "ec2role"
  }
}

#   <<EOF
    # {
    # "Version": "2012-10-17",
    # "Statement": [
    #     {
    #     "Action": [
    #         "ec2:Describe*"
    #     ],
    #     "Effect": "Allow",
    #     "Resource": "*"
    #     }
    # ]
    # }
    # EOF

#If you need to attach more policies
# resource "aws_iam_role_policy_attachment" "test-attach" {
#   role       = aws_iam_role.test_role.name
#   policy_arn = aws_iam_policy.testpolicy.arn
# }

resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.test_role.name
}