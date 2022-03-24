# terraform s3 remote backend


# How to use
If you didn't clone the repo yet, do that by accessing this [link](https://github.com/ion-onboarding/book-terraform-up) then return back here.\
Open a shell and drive to:
```
cd ch3/terraform-s3-remote-backend
```

# Steps how to move state to s3
- create main.tf
- create a dynamoDB table
- create an s3 bucket
- create local state: terraform init and terraform apply
- add s3 backend config within a terraform block (see S3 backend)[https://www.terraform.io/language/settings/backends/s3]
- move state with `terraform init`

## create main.tf
File main.tf is already in this repo

## create a dynamoDB table
DynamoDB table was created in `main.tf`

## create an s3 bucket
s3 bucket was created in `main.tf`

Note: if versioning is enabled you cannot do `terraform destroy`

## create local state: terraform init and terraform apply
```
terraform init
```

```
terraform apply
```

## add s3 backend config within a terraform block
main.tf contains a commented terraform block at end of file.

Uncomment the terraform block.

## move state with `terraform init`
```
terraform init
```

# Sample output

## Create local state
```
terraform init

Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Finding latest version of hashicorp/null...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/null v3.1.1...
- Installed hashicorp/null v3.1.1 (signed by HashiCorp)
- Installing hashicorp/aws v4.6.0...
- Installed hashicorp/aws v4.6.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

```
terraform apply 

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_dynamodb_table.terraform-locks will be created
  + resource "aws_dynamodb_table" "terraform-locks" {
      + arn              = (known after apply)
      + billing_mode     = "PAY_PER_REQUEST"
      + hash_key         = "LockID"
      + id               = (known after apply)
      + name             = "terraform-locks"
      + read_capacity    = (known after apply)
      + stream_arn       = (known after apply)
      + stream_label     = (known after apply)
      + stream_view_type = (known after apply)
      + tags             = {
          + "usedfor" = "terraform-remote-state"
        }
      + tags_all         = {
          + "usedfor" = "terraform-remote-state"
        }
      + write_capacity   = (known after apply)

      + attribute {
          + name = "LockID"
          + type = "S"
        }

      + point_in_time_recovery {
          + enabled = (known after apply)
        }

      + server_side_encryption {
          + enabled     = (known after apply)
          + kms_key_arn = (known after apply)
        }

      + ttl {
          + attribute_name = (known after apply)
          + enabled        = (known after apply)
        }
    }

  # aws_kms_alias.alias-key-bucket will be created
  + resource "aws_kms_alias" "alias-key-bucket" {
      + arn            = (known after apply)
      + id             = (known after apply)
      + name           = "alias/keybucketterraform"
      + name_prefix    = (known after apply)
      + target_key_arn = (known after apply)
      + target_key_id  = (known after apply)
    }

  # aws_kms_key.key-bucket will be created
  + resource "aws_kms_key" "key-bucket" {
      + arn                                = (known after apply)
      + bypass_policy_lockout_safety_check = false
      + customer_master_key_spec           = "SYMMETRIC_DEFAULT"
      + description                        = "This key is used to encrypt bucket objects"
      + enable_key_rotation                = false
      + id                                 = (known after apply)
      + is_enabled                         = true
      + key_id                             = (known after apply)
      + key_usage                          = "ENCRYPT_DECRYPT"
      + multi_region                       = (known after apply)
      + policy                             = (known after apply)
      + tags_all                           = (known after apply)
    }

  # aws_s3_bucket.bucket will be created
  + resource "aws_s3_bucket" "bucket" {
      + acceleration_status                  = (known after apply)
      + acl                                  = (known after apply)
      + arn                                  = (known after apply)
      + bucket                               = "bucket-terraform-remote-state-abc123"
      + bucket_domain_name                   = (known after apply)
      + bucket_regional_domain_name          = (known after apply)
      + cors_rule                            = (known after apply)
      + force_destroy                        = false
      + grant                                = (known after apply)
      + hosted_zone_id                       = (known after apply)
      + id                                   = (known after apply)
      + lifecycle_rule                       = (known after apply)
      + logging                              = (known after apply)
      + object_lock_enabled                  = (known after apply)
      + policy                               = (known after apply)
      + region                               = (known after apply)
      + replication_configuration            = (known after apply)
      + request_payer                        = (known after apply)
      + server_side_encryption_configuration = (known after apply)
      + tags                                 = {
          + "Environment" = "terraform-remote-state"
          + "Name"        = "usedfor"
        }
      + tags_all                             = {
          + "Environment" = "terraform-remote-state"
          + "Name"        = "usedfor"
        }
      + versioning                           = (known after apply)
      + website                              = (known after apply)
      + website_domain                       = (known after apply)
      + website_endpoint                     = (known after apply)

      + object_lock_configuration {
          + object_lock_enabled = (known after apply)
          + rule                = (known after apply)
        }
    }

  # aws_s3_bucket_server_side_encryption_configuration.example will be created
  + resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
      + bucket = "bucket-terraform-remote-state-abc123"
      + id     = (known after apply)

      + rule {
          + apply_server_side_encryption_by_default {
              + kms_master_key_id = (known after apply)
              + sse_algorithm     = "aws:kms"
            }
        }
    }

  # aws_s3_bucket_versioning.versioning-bucket will be created
  + resource "aws_s3_bucket_versioning" "versioning-bucket" {
      + bucket = (known after apply)
      + id     = (known after apply)

      + versioning_configuration {
          + mfa_delete = (known after apply)
          + status     = "Enabled"
        }
    }

  # null_resource.nothing will be created
  + resource "null_resource" "nothing" {
      + id = (known after apply)
    }

Plan: 7 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

null_resource.nothing: Creating...
null_resource.nothing: Creation complete after 0s [id=8360522152082420682]
aws_kms_key.key-bucket: Creating...
aws_dynamodb_table.terraform-locks: Creating...
aws_s3_bucket.bucket: Creating...
aws_kms_key.key-bucket: Creation complete after 0s [id=50474045-37b4-430e-bf8e-06e617db4a65]
aws_kms_alias.alias-key-bucket: Creating...
aws_kms_alias.alias-key-bucket: Creation complete after 0s [id=alias/keybucketterraform]
aws_s3_bucket.bucket: Creation complete after 2s [id=bucket-terraform-remote-state-abc123]
aws_s3_bucket_versioning.versioning-bucket: Creating...
aws_s3_bucket_server_side_encryption_configuration.example: Creating...
aws_s3_bucket_server_side_encryption_configuration.example: Creation complete after 1s [id=bucket-terraform-remote-state-abc123]
aws_s3_bucket_versioning.versioning-bucket: Creation complete after 2s [id=bucket-terraform-remote-state-abc123]
aws_dynamodb_table.terraform-locks: Creation complete after 7s [id=terraform-locks]

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.
```

## uncomment in main.tf the terraform block
terraform uncommented block at end of file main.tf looks like this
```
terraform {
   # dynamoDB key_name MUST match "LockID" string
  # https://www.terraform.io/language/settings/backends/s3
  backend "s3" {
    # Replace this with your bucket name and adjust the region!
    bucket         = "bucket-terraform-remote-state-abc123"
    key            = "terraform.tfstate"
    region         = "eu-north-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-remote-backend-locks"
    encrypt        = true
  }
}
```

```
terraform init

Initializing the backend...
Do you want to copy existing state to the new backend?
  Pre-existing state was found while migrating the previous "local" backend to the
  newly configured "s3" backend. No existing state was found in the newly
  configured "s3" backend. Do you want to copy this state to the new "s3"
  backend? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: yes


Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/null from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/null v3.1.1
- Using previously-installed hashicorp/aws v4.6.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
