resource "aws_s3_bucket" "incoming" {
  bucket = local.bucket_name
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_alias.ingest.id
      }
    }
  }

  versioning {
    enabled = true
  }
}

resource "aws_kms_key" "incoming" {
  description             = "Encryption Key for the S3 Bucket"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "ingest" {
  name          = "alias/${local.bucket_name}"
  target_key_id = aws_kms_key.incoming.key_id
}
