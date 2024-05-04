variable "bucket_name" {
  default = "facefinder"
}

variable "project" {
  default = "facefinder"
}
variable "env" {
  default = "dev"
}

variable "lambda_func_arn" {
  type = string
}