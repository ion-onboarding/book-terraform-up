variable "region" {
  description = "AWS region"
  default     = "eu-north-1"
  type        = string
}

variable "bucket_name" {
  description = "name of bucket, must be globally unique"
  default     = "bucket-terraform-remote-state-abc123"
  type        = string
}

provider "aws" {
  region = var.region
}

# S3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "usedfor"
    Environment = "terraform-remote-state"
  }
}

# DB for locking
resource "aws_dynamodb_table" "terraform-locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  # for s3, hash_key MUST be LockID (key sensitive)
  # https://www.terraform.io/language/settings/backends/s3#dynamodb-state-locking
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    usedfor = "terraform-remote-state"
  }
}
