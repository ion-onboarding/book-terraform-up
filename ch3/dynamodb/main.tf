variable "region" {
  description = "AWS region"
  default     = "eu-north-1"
  type        = string
}

provider "aws" {
  region = var.region
}

resource "aws_dynamodb_table" "table_employees" {
  name         = "employees"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "employeeid"
  attribute {
    name = "employeeid"
    type = "S"
  }
  tags = {
    environment = "test-dev"
  }
}

output "dynamodb_arn" {
  value = aws_dynamodb_table.table_employees.arn
}