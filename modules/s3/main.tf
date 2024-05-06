resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  force_destroy = true

  tags = {
    Name = "${var.project}+${var.env}-bucket"
  }
}

//Make the bucket publicly available
resource "aws_s3_bucket_public_access_block" "bucket" {
    bucket = aws_s3_bucket.bucket.id
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

//Bucket policy
resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = aws_s3_bucket.bucket.id
    policy = jsonencode({
         "Version": "2012-10-17",
         "Statement": [
            {
                "Sid": "Statement1",
                "Effect": "Allow",
                "Principal": "*",
                "Action": "s3:*",
                "Resource": "arn:aws:s3:::${var.bucket_name}/*"
            }
        ]
    })
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = var.lambda_func_arn
    events              = ["s3:ObjectCreated:*"]
    # filter_prefix       = ""
    filter_suffix       = ".jpg"
  }

  # depends_on = [aws_lambda_permission.allow_bucket]
}
