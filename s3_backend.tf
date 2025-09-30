# Descomenta y adapta si quieres usar backend remoto (S3 + DynamoDB lock).
# Antes de usarlo, crea el bucket S3 y la tabla DynamoDB o ejecuta un pequeño script que los cree.
#
# terraform {
#   backend "s3" {
#     bucket         = "s3-techtest"
#     key            = "terraform/techtest-project/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "techtest-tabla"
#     encrypt        = true
#   }
# }
