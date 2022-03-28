# Terraform s3 remote backend
This repository will explain how ot create a remote backend with s3 plus dynamoDB locking

# General Steps
Create 2 sets of configurations in separate directories:
1. s3 bucket & dynamodb (locking)
2. resources & remote backend config

More specifically
1. create s3 bucket and dynamoDB table in main.tf located in `state1-storage-lock` directory
    - within directory `state1-storage-lock` perform `terraform init` and `terraform apply`
2. create a null resource and define the s3 backend in `state2-resources`
    - within directory `state2-resources` use `terraform init` to move the state to s3

See [documentation](https://www.terraform.io/language/settings/backends/s3).

Note: both directories and terraform files were created already in this repo.

# How to use this repo
If you didn't clone the repo yet, do that by accessing this [link](https://github.com/ion-onboarding/book-terraform-up) then return back here.\
Open a shell and drive to:
```
cd ch3/s3-remote-backend
```

## s3 bucket and dynamoDB table
```
cd state1-storage-lock
```
```
terraform init
```
```
terraform apply
```

## 