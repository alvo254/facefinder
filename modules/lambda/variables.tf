variable "subnet_id" {
  type = string
}

variable "security_group" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "event_rule" {
  description = "This is the aws cloudwatch event rule  arn"
  type        = string
}

variable "bucket_arn" {
  type = string
}

