variable "ingress" {
  type = any
  default = {
    ssh = {
      port = 22
    },
    http = {
      description = "TLS from VPC"
      port        = 80

    },
    tomcat = {
      port        = 8080
      cidr_blocks = ["172.25.12.31/32"]
    }
  }
}

variable "env" {
  
}
variable "namespace" {
  
}

variable "tags" {
  env = "development"
  project = "cloudblitz"
  owner = "cloudblitz"
 team = "devops"
}
variable "subnetid" {
}
variable "privatesubnet" {
  
}
variable "vpccidr" {
  
}
variable "allname" {
  
}
variable "ami" {
}
variable "instancetype" {
}
variable "publicip" {
}
variable "profile" {
}
variable "sg" {
}
variable "allname" { 
}
