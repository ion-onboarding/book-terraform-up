# AWS S3 bucket
- create an S3 bucket
    - create encryption key
    - enable versioning
    - enable server side encryption with created key

# How to use
If you didn't clone the repo yet, do that by accessing this [link](https://github.com/ion-onboarding/book-terraform-up) then return back here.\
Open a shell and drive to:
```
cd ch3/s3-bucket
```

# Create resources
```
terraform init
```
```
terraform apply -auto-approve
```

# Destroy resources
```
terraform destroy -auto-approve
```