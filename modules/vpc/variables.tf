variable "vpc_cidr"{
  default = "172.16.0.0/20"
}


variable "project" {
  default = "facefinder"
}

variable "env" {
  default = "dev"
}

variable "public_subnet" {
  default = "172.16.0.0/22"
}