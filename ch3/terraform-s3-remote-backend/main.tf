variable "region" {
  description = "AWS region"
  default     = "eu-north-1"
  type        = string
}

variable "bucket_name" {
  description = "bucket name for terraform remote backend"
  default     = "bucket-terraform-remote-state-abc123"
  type        = string
}

provider "aws" {
  region = var.region
}

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

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "usedfor"
    Environment = "terraform-remote-state"
  }
}

resource "aws_kms_key" "key-bucket" {
  description = "This key is used to encrypt bucket objects"
}

resource "aws_kms_alias" "alias-key-bucket" {
  name          = "alias/keybucketterraform"
  target_key_id = aws_kms_key.key-bucket.key_id
}

resource "aws_s3_bucket_versioning" "versioning-bucket" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.key-bucket.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "null_resource" "nothing" {

}

terraform {
  # dynamoDB key_name MUST match "LockID" string
  # https://www.terraform.io/language/settings/backends/s3
  backend "s3" {
    # Replace this with your bucket name and adjust the region!
    bucket = "bucket-terraform-remote-state-abc123"
    key    = "terraform.tfstate"
    region = "eu-north-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
