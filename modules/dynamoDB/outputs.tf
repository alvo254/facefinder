output "bucket_name" {
  description = "Name of the S3 bucket where the photo was uploaded"
  value       = aws_dynamodb_table.face_images.name
}

output "object_key" {
  description = "Key of the uploaded photo in the S3 bucket"
  value       = aws_dynamodb_table.face_images.hash_key
}

output "face_details" {
  description = "Details of faces detected in the uploaded photo"
  value       = aws_dynamodb_table.face_images.range_key
}