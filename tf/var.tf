variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}
variable "name" {
  type = string
}

variable "subnetid" {
  type = list(any)
}
variable "vpc" {
}
variable "allname" {}
