data "archive_file" "lambda_zip" {
  type             = "zip"
  source_file      = "${path.module}/src/s3_list_files.py"
  output_file_mode = "0666"
  output_path      = "${path.module}/bin/s3_list_files.zip"
}

resource "aws_lambda_function" "conversion_lambda" {
  runtime          = "python3.9"
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = local.lambda_name
  handler          = "s3_list_files.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  memory_size      = 3000
  timeout          = 900
  environment {
    variables = {
      incoming_bucket_arn = aws_s3_bucket.incoming.arn
    }
  }
}
