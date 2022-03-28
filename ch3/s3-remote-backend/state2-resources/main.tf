resource "null_resource" "nothing" {}

terraform {
  backend "s3" {
    bucket = "bucket-terraform-remote-state-abc123"
    key    = "global/terraform.tfstate"
    region = "eu-north-1"
    dynamodb_table = "terraform-locks"
  }
}