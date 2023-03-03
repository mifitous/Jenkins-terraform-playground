resource "aws_iam_role_policy" "lambda" {
  name = "s3_policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKey",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:HeadObject",
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject"
        ]
        Resource = [
          "*",
        ]
      }
    ]
  })
}
