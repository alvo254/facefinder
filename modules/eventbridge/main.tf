# resource "aws_cloudwatch_event_rule" "s3_event_rule" {
#   name        = "s3_event_rule"
#   description = "Watch for S3 object creation events"
#   event_pattern = jsonencode({
#     source      = ["aws.s3"],
#     "detail-type" = ["AWS API Call via CloudTrail"],
#     detail = {
#       eventSource = ["s3.amazonaws.com"],
#       eventName   = ["PutObject", "CompleteMultipartUpload"],
#       requestParameters = {
#         bucketName = [var.bucket_name]
#       }


#     }
#   })
# }

resource "aws_cloudwatch_event_rule" "image_upload_rule" {
  name        = "image-upload-rule"
  description = "Triggers when an image is uploaded to S3"

  event_pattern = <<PATTERN
{
  "source": ["aws.s3"],
  "detail-type": ["Object Created"],
  "detail": {
    "bucket": {
      "name": ["${var.bucket_name}"]
    },
    "object": {
      "key": [".+\\.(?:jpg|png|jpeg)$"]
    }
  }
}
PATTERN
}



resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.image_upload_rule.name
  target_id = "lambda_target"
  arn       = var.lambda_func_arn
  #   input     = "{\"bucketName\": \"your-s3-bucket-name\", \"objectKey\": \"\${detail.requestParameters.key}\"}"
}

