output "vpc_id" {
  value = aws_vpc.facefinder.id
}

output "public_subnet" {
  value = aws_subnet.public_subnet.id
}
