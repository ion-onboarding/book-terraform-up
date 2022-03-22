variable "region" {
    description = "AWS region to be used"
    default = "eu-north-1"
}

provider "aws" {
  region = var.region
}

# generate random names to be added at the end of bucket (bucket name is globally unique)
resource "random_pet" "random_string" {
  length = 3
  prefix = "-"
}
resource "aws_kms_key" "key-bucket" {
  description = "This key is used to encrypt bucket objects"
}

resource "aws_kms_alias" "alias-key-bucket" {
  name          = "alias/keyionbucket"
  target_key_id = aws_kms_key.key-bucket.key_id
}

resource "aws_s3_bucket" "bucket" {
  bucket = "bucket${random_pet.random_string.id}"

  tags = {
    Name        = "remote-state"
    Environment = "test"
  }
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