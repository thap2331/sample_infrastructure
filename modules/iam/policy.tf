resource "aws_iam_policy" "testpolicy" {
  name        = "test_policy"
  description = "My test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
            "s3:GetBucketLocation",
            "s3:GetAccountPublicAccessBlock",
            "s3:ListAccessPoints",
            "s3:ListAllMyBuckets"
            ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })

}