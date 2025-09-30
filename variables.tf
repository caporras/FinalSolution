variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "techtest_terraform-docker"
}


variable "ssh_allowed_cidr" {
  type    = string
  default = "152.231.189.199/32"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "db_username" {
  type    = string
  default = "techtest_user"
  sensitive   = false
}

variable "db_password" {
  type    = string
  default = "techtest_pass"
  sensitive = true
}

variable "ecr_repository_name" {
  type    = string
  default = "techtest_ECR"
}

variable "docker_image_uri" {
  description = "URI de la imagen ECR para usar en EC2"
  type        = string
}
