# AWS ubuntu with terraform
- creates an ubuntu image and returns SSH details to login to it
- uses busy box to return a static web page on port 80

# How to use
Open shell and drive to `book-terraform-up/ch2/ex1-simple-instance`

## Create resources
```
terraform apply -auto-approve
```

## Delete resources
```
terrafrom destroy -auto-approve
```
