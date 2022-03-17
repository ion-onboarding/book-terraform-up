# AWS ubuntu with terraform
- creates AWS ASG (auto scaling group) with 2 ubuntu images on 2 public subnets
- LoadBalancer will forward HTTP to ubuntu servers, running busybox httpd
- SSH is exposed via public IPs

# How to use
If you didn't clone the repo yet, do that by accessing this [link](https://github.com/ion-onboarding/book-terraform-up) then return back here.\
Open a shell and drive to:
```
cd ch2/ex2-asg-lb-pub-subnet
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

