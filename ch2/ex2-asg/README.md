# AWS ubuntu with terraform
- creates AWS auto scaling group with 3 ubuntu images
- servers in ASG will return via busybox a static web page on port 80
- terraform returns WWW/SSH details on how to connect

# How to use
If you didn't clone the repo yet, do that by accessing this [link](https://github.com/ion-onboarding/book-terraform-up) then return back here.\
Open a shell and drive to:
```
cd ch2/ex2-asg
```

## Create resources
```
terraform init
```
```
terraform apply -auto-approve
```

## output connection details for WWW and SSH
```
terraform output
```

## Delete resources
```
terraform destroy -auto-approve
```
