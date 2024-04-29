resource "aws_dynamodb_table" "face_images" {
  name           = "FaceImages"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "BucketName"
  range_key      = "ObjectKey"

  attribute {
    name = "BucketName"
    type = "S"
  }

  attribute {
    name = "ObjectKey"
    type = "S"
  }

  attribute {
    name = "FaceDetails"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  global_secondary_index {
    name               = "ObjectKeyIndex"
    hash_key           = "BucketName"
    range_key          = "FaceDetails"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["FaceDetails"]
  }


  tags = {
    Name        = "${var.project}-${var.env}-dynamoDB-table"
  }
}

