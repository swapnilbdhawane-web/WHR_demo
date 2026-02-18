resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

# Block all public access (recommended)
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

resource "aws_s3_object" "hello" {
  bucket = aws_s3_bucket.this.bucket
  key    = "uploads/hello.txt"          # path inside the bucket
  source = "${path.module}/files/hello.txt"

  etag = filemd5("${path.module}/files/hello.txt") # forces updates when file changes
}
