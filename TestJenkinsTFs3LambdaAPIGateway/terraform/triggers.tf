resource "aws_s3_bucket_notification" "incoming" {
  bucket = aws_s3_bucket.incoming.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.conversion_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "zip-files"
    filter_suffix       = ".zip"
  }

  depends_on = [aws_lambda_permission.s3_permission_to_trigger_lambda]
}

resource "aws_lambda_permission" "s3_permission_to_trigger_lambda" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.conversion_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.incoming.arn
}
