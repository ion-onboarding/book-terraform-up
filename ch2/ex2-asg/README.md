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

## output connection details for WWW and SSH (# of servers in ASG changes)
If a server in the ASG is replaced or if more servers in the ASG come online,\
do terraform apply so that current and new servers from ASG are read:
```
terraform apply -auto-approve
```
```
terraform output
```

## Delete resources
```
terraform destroy -auto-approve
```

# Sample output: resources are created
```
$ terraform output
access_SSH = tolist([
  "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.48.24.60",
  "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.49.0.149",
  "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.53.123.252",
])
access_WWW = tolist([
  "http://13.48.24.60",
  "http://13.49.0.149",
  "http://13.53.123.252",
])
```
```
$ curl http://13.48.24.60
<h1 style=text-align:center>Hello from hostname <span style=color:green>ip-10-0-1-246<span></h1>
<h1 style=text-align:center>public IP:<span style=color:green>13.48.24.60<span></h1>
```

```
ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.48.24.60
Warning: Permanently added '13.48.24.60' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.13.0-1017-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Mar 15 11:20:26 UTC 2022

  System load:  0.09              Processes:             114
  Usage of /:   18.4% of 7.69GB   Users logged in:       0
  Memory usage: 20%               IPv4 address for ens5: 10.0.1.246
  Swap usage:   0%

1 update can be applied immediately.
To see these additional updates run: apt list --upgradable



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@ip-10-0-1-246:~$ 
```

# Sample output terraform

## creating resources
```
terraform init
Initializing modules...
- vpc in modules/vpc

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "4.5.0"...
- Finding latest version of hashicorp/tls...
- Finding latest version of hashicorp/local...
- Finding latest version of hashicorp/random...
- Installing hashicorp/tls v3.1.0...
- Installed hashicorp/tls v3.1.0 (signed by HashiCorp)
- Installing hashicorp/local v2.2.2...
- Installed hashicorp/local v2.2.2 (signed by HashiCorp)
- Installing hashicorp/random v3.1.0...
- Installed hashicorp/random v3.1.0 (signed by HashiCorp)
- Installing hashicorp/aws v4.5.0...
- Installed hashicorp/aws v4.5.0 (signed by HashiCorp)

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
terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # data.aws_instances.asg-instances will be read during apply
  # (config refers to values not yet known)
 <= data "aws_instances" "asg-instances"  {
      + id                   = (known after apply)
      + ids                  = (known after apply)
      + instance_state_names = [
          + "running",
        ]
      + instance_tags        = {
          + "Name" = (known after apply)
        }
      + private_ips          = (known after apply)
      + public_ips           = (known after apply)
    }

  # aws_autoscaling_group.ubuntu will be created
  + resource "aws_autoscaling_group" "ubuntu" {
      + arn                       = (known after apply)
      + availability_zones        = (known after apply)
      + default_cooldown          = (known after apply)
      + desired_capacity          = 3
      + force_delete              = false
      + force_delete_warm_pool    = false
      + health_check_grace_period = 300
      + health_check_type         = (known after apply)
      + id                        = (known after apply)
      + launch_configuration      = (known after apply)
      + max_size                  = 4
      + metrics_granularity       = "1Minute"
      + min_size                  = 3
      + name                      = (known after apply)
      + name_prefix               = (known after apply)
      + protect_from_scale_in     = false
      + service_linked_role_arn   = (known after apply)
      + vpc_zone_identifier       = (known after apply)
      + wait_for_capacity_timeout = "10m"

      + tag {
          + key                 = "Name"
          + propagate_at_launch = true
          + value               = (known after apply)
        }
    }

  # aws_key_pair.ssh-key will be created
  + resource "aws_key_pair" "ssh-key" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = (known after apply)
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + public_key      = (known after apply)
      + tags            = (known after apply)
      + tags_all        = (known after apply)
    }

  # aws_launch_configuration.ubuntu will be created
  + resource "aws_launch_configuration" "ubuntu" {
      + arn                         = (known after apply)
      + associate_public_ip_address = true
      + ebs_optimized               = (known after apply)
      + enable_monitoring           = true
      + id                          = (known after apply)
      + image_id                    = "ami-04e4f9b92505045dd"
      + instance_type               = "t3.micro"
      + key_name                    = (known after apply)
      + name                        = (known after apply)
      + name_prefix                 = (known after apply)
      + security_groups             = (known after apply)
      + user_data                   = "63efe6b160b78adf93fbe6e3fcbcc1a6e0daf630"

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + no_device             = (known after apply)
          + snapshot_id           = (known after apply)
          + throughput            = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + throughput            = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # local_file.ssh-key-file will be created
  + resource "local_file" "ssh-key-file" {
      + content              = (sensitive)
      + directory_permission = "0777"
      + file_permission      = "0600"
      + filename             = "./artifacts/id_rsa.priv"
      + id                   = (known after apply)
    }

  # random_pet.suffix_name will be created
  + resource "random_pet" "suffix_name" {
      + id        = (known after apply)
      + length    = 1
      + separator = "-"
    }

  # tls_private_key.keys will be created
  + resource "tls_private_key" "keys" {
      + algorithm                  = "RSA"
      + ecdsa_curve                = "P224"
      + id                         = (known after apply)
      + private_key_pem            = (sensitive value)
      + public_key_fingerprint_md5 = (known after apply)
      + public_key_openssh         = (known after apply)
      + public_key_pem             = (known after apply)
      + rsa_bits                   = 2048
    }

  # module.vpc.aws_internet_gateway.gw will be created
  + resource "aws_internet_gateway" "gw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = (known after apply)
      + tags_all = (known after apply)
      + vpc_id   = (known after apply)
    }

  # module.vpc.aws_route_table.route_table will be created
  + resource "aws_route_table" "route_table" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + instance_id                = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = (known after apply)
      + tags_all         = (known after apply)
      + vpc_id           = (known after apply)
    }

  # module.vpc.aws_route_table_association.a will be created
  + resource "aws_route_table_association" "a" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.vpc.aws_security_group.sg-ubuntu will be created
  + resource "aws_security_group" "sg-ubuntu" {
      + arn                    = (known after apply)
      + description            = "Allow inbound traffic"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "Enter SSH"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "Enter WEB"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "sgserver-ubuntu"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = (known after apply)
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # module.vpc.aws_subnet.subnet_private will be created
  + resource "aws_subnet" "subnet_private" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = (known after apply)
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = (known after apply)
      + tags_all                                       = (known after apply)
      + vpc_id                                         = (known after apply)
    }

  # module.vpc.aws_vpc.vpc will be created
  + resource "aws_vpc" "vpc" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.0.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_classiclink                   = (known after apply)
      + enable_classiclink_dns_support       = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = (known after apply)
      + tags_all                             = (known after apply)
    }

Plan: 12 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + access_SSH = (known after apply)
  + access_WWW = (known after apply)
tls_private_key.keys: Creating...
random_pet.suffix_name: Creating...
random_pet.suffix_name: Creation complete after 0s [id=possum]
tls_private_key.keys: Creation complete after 0s [id=4d0dc2ca17ee37787152e3a0c140b2749a014bad]
local_file.ssh-key-file: Creating...
local_file.ssh-key-file: Creation complete after 0s [id=8377628b57d58a15d7711a193742f6ec0d862d2d]
module.vpc.aws_vpc.vpc: Creating...
aws_key_pair.ssh-key: Creating...
aws_key_pair.ssh-key: Creation complete after 0s [id=ion-ssh-key-possum]
module.vpc.aws_vpc.vpc: Still creating... [10s elapsed]
module.vpc.aws_vpc.vpc: Creation complete after 11s [id=vpc-0cba03045af90e3e5]
module.vpc.aws_internet_gateway.gw: Creating...
module.vpc.aws_subnet.subnet_private: Creating...
module.vpc.aws_security_group.sg-ubuntu: Creating...
module.vpc.aws_internet_gateway.gw: Creation complete after 1s [id=igw-0edb319475813080d]
module.vpc.aws_route_table.route_table: Creating...
module.vpc.aws_subnet.subnet_private: Creation complete after 1s [id=subnet-0aa096f7b3f739d72]
module.vpc.aws_route_table.route_table: Creation complete after 0s [id=rtb-02945f9ab463d0f60]
module.vpc.aws_route_table_association.a: Creating...
module.vpc.aws_route_table_association.a: Creation complete after 1s [id=rtbassoc-04fe24efd83ef648e]
module.vpc.aws_security_group.sg-ubuntu: Creation complete after 3s [id=sg-0252e86a1349b3c42]
aws_launch_configuration.ubuntu: Creating...
aws_launch_configuration.ubuntu: Creation complete after 0s [id=possum_launch_20220315111821691000000001]
aws_autoscaling_group.ubuntu: Creating...
aws_autoscaling_group.ubuntu: Still creating... [10s elapsed]
aws_autoscaling_group.ubuntu: Still creating... [20s elapsed]
aws_autoscaling_group.ubuntu: Creation complete after 27s [id=terraform-20220315111822219600000002]
data.aws_instances.asg-instances: Reading...
data.aws_instances.asg-instances: Read complete after 0s [id=eu-north-1]

Apply complete! Resources: 12 added, 0 changed, 0 destroyed.

Outputs:

access_SSH = tolist([
  "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.48.24.60",
  "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.49.0.149",
  "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.53.123.252",
])
access_WWW = tolist([
  "http://13.48.24.60",
  "http://13.49.0.149",
  "http://13.53.123.252",
])
```

## Deleting resources
```
terraform destroy -auto-approve
random_pet.suffix_name: Refreshing state... [id=possum]
tls_private_key.keys: Refreshing state... [id=4d0dc2ca17ee37787152e3a0c140b2749a014bad]
local_file.ssh-key-file: Refreshing state... [id=8377628b57d58a15d7711a193742f6ec0d862d2d]
aws_key_pair.ssh-key: Refreshing state... [id=ion-ssh-key-possum]
module.vpc.aws_vpc.vpc: Refreshing state... [id=vpc-0cba03045af90e3e5]
module.vpc.aws_internet_gateway.gw: Refreshing state... [id=igw-0edb319475813080d]
module.vpc.aws_subnet.subnet_private: Refreshing state... [id=subnet-0aa096f7b3f739d72]
module.vpc.aws_security_group.sg-ubuntu: Refreshing state... [id=sg-0252e86a1349b3c42]
module.vpc.aws_route_table.route_table: Refreshing state... [id=rtb-02945f9ab463d0f60]
aws_launch_configuration.ubuntu: Refreshing state... [id=possum_launch_20220315111821691000000001]
module.vpc.aws_route_table_association.a: Refreshing state... [id=rtbassoc-04fe24efd83ef648e]
aws_autoscaling_group.ubuntu: Refreshing state... [id=terraform-20220315111822219600000002]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_autoscaling_group.ubuntu will be destroyed
  - resource "aws_autoscaling_group" "ubuntu" {
      - arn                       = "arn:aws:autoscaling:eu-north-1:267023797923:autoScalingGroup:b0d2b4c8-9198-4999-88b2-4f5b379b1980:autoScalingGroupName/terraform-20220315111822219600000002" -> null
      - availability_zones        = [
          - "eu-north-1a",
        ] -> null
      - capacity_rebalance        = false -> null
      - default_cooldown          = 300 -> null
      - desired_capacity          = 3 -> null
      - enabled_metrics           = [] -> null
      - force_delete              = false -> null
      - force_delete_warm_pool    = false -> null
      - health_check_grace_period = 300 -> null
      - health_check_type         = "EC2" -> null
      - id                        = "terraform-20220315111822219600000002" -> null
      - launch_configuration      = "possum_launch_20220315111821691000000001" -> null
      - load_balancers            = [] -> null
      - max_instance_lifetime     = 0 -> null
      - max_size                  = 4 -> null
      - metrics_granularity       = "1Minute" -> null
      - min_size                  = 3 -> null
      - name                      = "terraform-20220315111822219600000002" -> null
      - name_prefix               = "terraform-" -> null
      - protect_from_scale_in     = false -> null
      - service_linked_role_arn   = "arn:aws:iam::267023797923:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling" -> null
      - suspended_processes       = [] -> null
      - target_group_arns         = [] -> null
      - termination_policies      = [] -> null
      - vpc_zone_identifier       = [
          - "subnet-0aa096f7b3f739d72",
        ] -> null
      - wait_for_capacity_timeout = "10m" -> null

      - tag {
          - key                 = "Name" -> null
          - propagate_at_launch = true -> null
          - value               = "possum_asg-ubuntu_" -> null
        }
    }

  # aws_key_pair.ssh-key will be destroyed
  - resource "aws_key_pair" "ssh-key" {
      - arn         = "arn:aws:ec2:eu-north-1:267023797923:key-pair/ion-ssh-key-possum" -> null
      - fingerprint = "6f:ec:35:8a:3d:52:01:8a:66:9e:29:91:fa:18:b6:b8" -> null
      - id          = "ion-ssh-key-possum" -> null
      - key_name    = "ion-ssh-key-possum" -> null
      - key_pair_id = "key-0cbb253d29cc1dd54" -> null
      - public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDO/hqNegJhQKja6p1PK3K8ou/WUbWzBVln5xBLufTUv+UWmwl72VB3eSViAFyLEwd4eNyJCNfCRT/UETPW25qmBd25sz5YFHycH8Pec+BTZPgsyCoNwGUtYrqa2HW7uXGItO5h15xT9KpNDbS/uA6LfJ+S6G/O0g+iF9K8cs6rIvZqMRJYl6jKX3F2QytB+zDimTTbD1FhFbGX9fWOQYuEUXbFqGeg07KnwhciF0HG3mTc+/7ZGhAqj3DjrFpbQ8OVf+Y+kBZrftIr/Zp/RnJqg1DcTTdxiLhufEXsOcUQ46LWK28E7rkOiABgf6f9CfkF5PbCRC5xxC50nV+BYlm3" -> null
      - tags        = {
          - "Name" = "ion-key-pair-possum"
        } -> null
      - tags_all    = {
          - "Name" = "ion-key-pair-possum"
        } -> null
    }

  # aws_launch_configuration.ubuntu will be destroyed
  - resource "aws_launch_configuration" "ubuntu" {
      - arn                              = "arn:aws:autoscaling:eu-north-1:267023797923:launchConfiguration:3394a99b-3130-444e-bfbe-b85a6f5b1ca3:launchConfigurationName/possum_launch_20220315111821691000000001" -> null
      - associate_public_ip_address      = true -> null
      - ebs_optimized                    = false -> null
      - enable_monitoring                = true -> null
      - id                               = "possum_launch_20220315111821691000000001" -> null
      - image_id                         = "ami-04e4f9b92505045dd" -> null
      - instance_type                    = "t3.micro" -> null
      - key_name                         = "ion-ssh-key-possum" -> null
      - name                             = "possum_launch_20220315111821691000000001" -> null
      - name_prefix                      = "possum_launch_" -> null
      - security_groups                  = [
          - "sg-0252e86a1349b3c42",
        ] -> null
      - user_data                        = "63efe6b160b78adf93fbe6e3fcbcc1a6e0daf630" -> null
      - vpc_classic_link_security_groups = [] -> null
    }

  # local_file.ssh-key-file will be destroyed
  - resource "local_file" "ssh-key-file" {
      - content              = (sensitive) -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0600" -> null
      - filename             = "./artifacts/id_rsa.priv" -> null
      - id                   = "8377628b57d58a15d7711a193742f6ec0d862d2d" -> null
    }

  # random_pet.suffix_name will be destroyed
  - resource "random_pet" "suffix_name" {
      - id        = "possum" -> null
      - length    = 1 -> null
      - separator = "-" -> null
    }

  # tls_private_key.keys will be destroyed
  - resource "tls_private_key" "keys" {
      - algorithm                  = "RSA" -> null
      - ecdsa_curve                = "P224" -> null
      - id                         = "4d0dc2ca17ee37787152e3a0c140b2749a014bad" -> null
      - private_key_pem            = (sensitive value)
      - public_key_fingerprint_md5 = "de:45:08:a6:77:de:96:93:0d:75:9d:2f:1c:b2:ab:a6" -> null
      - public_key_openssh         = <<-EOT
            ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDO/hqNegJhQKja6p1PK3K8ou/WUbWzBVln5xBLufTUv+UWmwl72VB3eSViAFyLEwd4eNyJCNfCRT/UETPW25qmBd25sz5YFHycH8Pec+BTZPgsyCoNwGUtYrqa2HW7uXGItO5h15xT9KpNDbS/uA6LfJ+S6G/O0g+iF9K8cs6rIvZqMRJYl6jKX3F2QytB+zDimTTbD1FhFbGX9fWOQYuEUXbFqGeg07KnwhciF0HG3mTc+/7ZGhAqj3DjrFpbQ8OVf+Y+kBZrftIr/Zp/RnJqg1DcTTdxiLhufEXsOcUQ46LWK28E7rkOiABgf6f9CfkF5PbCRC5xxC50nV+BYlm3
        EOT -> null
      - public_key_pem             = <<-EOT
            -----BEGIN PUBLIC KEY-----
            MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzv4ajXoCYUCo2uqdTyty
            vKLv1lG1swVZZ+cQS7n01L/lFpsJe9lQd3klYgBcixMHeHjciQjXwkU/1BEz1tua
            pgXdubM+WBR8nB/D3nPgU2T4LMgqDcBlLWK6mth1u7lxiLTuYdecU/SqTQ20v7gO
            i3yfkuhvztIPohfSvHLOqyL2ajESWJeoyl9xdkMrQfsw4pk02w9RYRWxl/X1jkGL
            hFF2xahnoNOyp8IXIhdBxt5k3Pv+2RoQKo9w46xaW0PDlX/mPpAWa37SK/2af0Zy
            aoNQ3E03cYi4bnxF7DnFEOOi1itvBO65DogAYH+n/Qn5BeT2wkQuccQudJ1fgWJZ
            twIDAQAB
            -----END PUBLIC KEY-----
        EOT -> null
      - rsa_bits                   = 2048 -> null
    }

  # module.vpc.aws_internet_gateway.gw will be destroyed
  - resource "aws_internet_gateway" "gw" {
      - arn      = "arn:aws:ec2:eu-north-1:267023797923:internet-gateway/igw-0edb319475813080d" -> null
      - id       = "igw-0edb319475813080d" -> null
      - owner_id = "267023797923" -> null
      - tags     = {
          - "Name" = "gw-possum"
        } -> null
      - tags_all = {
          - "Name" = "gw-possum"
        } -> null
      - vpc_id   = "vpc-0cba03045af90e3e5" -> null
    }

  # module.vpc.aws_route_table.route_table will be destroyed
  - resource "aws_route_table" "route_table" {
      - arn              = "arn:aws:ec2:eu-north-1:267023797923:route-table/rtb-02945f9ab463d0f60" -> null
      - id               = "rtb-02945f9ab463d0f60" -> null
      - owner_id         = "267023797923" -> null
      - propagating_vgws = [] -> null
      - route            = [
          - {
              - carrier_gateway_id         = ""
              - cidr_block                 = "0.0.0.0/0"
              - destination_prefix_list_id = ""
              - egress_only_gateway_id     = ""
              - gateway_id                 = "igw-0edb319475813080d"
              - instance_id                = ""
              - ipv6_cidr_block            = ""
              - local_gateway_id           = ""
              - nat_gateway_id             = ""
              - network_interface_id       = ""
              - transit_gateway_id         = ""
              - vpc_endpoint_id            = ""
              - vpc_peering_connection_id  = ""
            },
        ] -> null
      - tags             = {
          - "Name" = "route-table-possum"
        } -> null
      - tags_all         = {
          - "Name" = "route-table-possum"
        } -> null
      - vpc_id           = "vpc-0cba03045af90e3e5" -> null
    }

  # module.vpc.aws_route_table_association.a will be destroyed
  - resource "aws_route_table_association" "a" {
      - id             = "rtbassoc-04fe24efd83ef648e" -> null
      - route_table_id = "rtb-02945f9ab463d0f60" -> null
      - subnet_id      = "subnet-0aa096f7b3f739d72" -> null
    }

  # module.vpc.aws_security_group.sg-ubuntu will be destroyed
  - resource "aws_security_group" "sg-ubuntu" {
      - arn                    = "arn:aws:ec2:eu-north-1:267023797923:security-group/sg-0252e86a1349b3c42" -> null
      - description            = "Allow inbound traffic" -> null
      - egress                 = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 0
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "-1"
              - security_groups  = []
              - self             = false
              - to_port          = 0
            },
        ] -> null
      - id                     = "sg-0252e86a1349b3c42" -> null
      - ingress                = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = "Enter SSH"
              - from_port        = 22
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 22
            },
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = "Enter WEB"
              - from_port        = 80
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 80
            },
        ] -> null
      - name                   = "sgserver-ubuntu" -> null
      - owner_id               = "267023797923" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {
          - "Name" = "sg-server-possum"
        } -> null
      - tags_all               = {
          - "Name" = "sg-server-possum"
        } -> null
      - vpc_id                 = "vpc-0cba03045af90e3e5" -> null
    }

  # module.vpc.aws_subnet.subnet_private will be destroyed
  - resource "aws_subnet" "subnet_private" {
      - arn                                            = "arn:aws:ec2:eu-north-1:267023797923:subnet/subnet-0aa096f7b3f739d72" -> null
      - assign_ipv6_address_on_creation                = false -> null
      - availability_zone                              = "eu-north-1a" -> null
      - availability_zone_id                           = "eun1-az1" -> null
      - cidr_block                                     = "10.0.1.0/24" -> null
      - enable_dns64                                   = false -> null
      - enable_resource_name_dns_a_record_on_launch    = false -> null
      - enable_resource_name_dns_aaaa_record_on_launch = false -> null
      - id                                             = "subnet-0aa096f7b3f739d72" -> null
      - ipv6_native                                    = false -> null
      - map_customer_owned_ip_on_launch                = false -> null
      - map_public_ip_on_launch                        = false -> null
      - owner_id                                       = "267023797923" -> null
      - private_dns_hostname_type_on_launch            = "ip-name" -> null
      - tags                                           = {
          - "Name" = "subnet-possum"
        } -> null
      - tags_all                                       = {
          - "Name" = "subnet-possum"
        } -> null
      - vpc_id                                         = "vpc-0cba03045af90e3e5" -> null
    }

  # module.vpc.aws_vpc.vpc will be destroyed
  - resource "aws_vpc" "vpc" {
      - arn                              = "arn:aws:ec2:eu-north-1:267023797923:vpc/vpc-0cba03045af90e3e5" -> null
      - assign_generated_ipv6_cidr_block = false -> null
      - cidr_block                       = "10.0.0.0/16" -> null
      - default_network_acl_id           = "acl-0d3d1c1488db322fc" -> null
      - default_route_table_id           = "rtb-01bcad80ff2029341" -> null
      - default_security_group_id        = "sg-02d80755e1fdcd08c" -> null
      - dhcp_options_id                  = "dopt-c560cdac" -> null
      - enable_classiclink               = false -> null
      - enable_classiclink_dns_support   = false -> null
      - enable_dns_hostnames             = true -> null
      - enable_dns_support               = true -> null
      - id                               = "vpc-0cba03045af90e3e5" -> null
      - instance_tenancy                 = "default" -> null
      - ipv6_netmask_length              = 0 -> null
      - main_route_table_id              = "rtb-01bcad80ff2029341" -> null
      - owner_id                         = "267023797923" -> null
      - tags                             = {
          - "Name" = "vpc-possum"
        } -> null
      - tags_all                         = {
          - "Name" = "vpc-possum"
        } -> null
    }

Plan: 0 to add, 0 to change, 12 to destroy.

Changes to Outputs:
  - access_SSH = [
      - "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.48.24.60",
      - "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.49.0.149",
      - "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.53.123.252",
    ] -> null
  - access_WWW = [
      - "http://13.48.24.60",
      - "http://13.49.0.149",
      - "http://13.53.123.252",
    ] -> null
local_file.ssh-key-file: Destroying... [id=8377628b57d58a15d7711a193742f6ec0d862d2d]
local_file.ssh-key-file: Destruction complete after 0s
module.vpc.aws_route_table_association.a: Destroying... [id=rtbassoc-04fe24efd83ef648e]
module.vpc.aws_route_table_association.a: Destruction complete after 0s
module.vpc.aws_route_table.route_table: Destroying... [id=rtb-02945f9ab463d0f60]
aws_autoscaling_group.ubuntu: Destroying... [id=terraform-20220315111822219600000002]
module.vpc.aws_route_table.route_table: Destruction complete after 0s
module.vpc.aws_internet_gateway.gw: Destroying... [id=igw-0edb319475813080d]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220315111822219600000002, 10s elapsed]
module.vpc.aws_internet_gateway.gw: Still destroying... [id=igw-0edb319475813080d, 10s elapsed]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220315111822219600000002, 20s elapsed]
module.vpc.aws_internet_gateway.gw: Still destroying... [id=igw-0edb319475813080d, 20s elapsed]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220315111822219600000002, 30s elapsed]
module.vpc.aws_internet_gateway.gw: Still destroying... [id=igw-0edb319475813080d, 30s elapsed]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220315111822219600000002, 40s elapsed]
module.vpc.aws_internet_gateway.gw: Still destroying... [id=igw-0edb319475813080d, 40s elapsed]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220315111822219600000002, 50s elapsed]
module.vpc.aws_internet_gateway.gw: Still destroying... [id=igw-0edb319475813080d, 50s elapsed]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220315111822219600000002, 1m0s elapsed]
module.vpc.aws_internet_gateway.gw: Still destroying... [id=igw-0edb319475813080d, 1m0s elapsed]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220315111822219600000002, 1m10s elapsed]
module.vpc.aws_internet_gateway.gw: Still destroying... [id=igw-0edb319475813080d, 1m10s elapsed]
module.vpc.aws_internet_gateway.gw: Destruction complete after 1m19s
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220315111822219600000002, 1m20s elapsed]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220315111822219600000002, 1m30s elapsed]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220315111822219600000002, 1m40s elapsed]
aws_autoscaling_group.ubuntu: Destruction complete after 1m40s
module.vpc.aws_subnet.subnet_private: Destroying... [id=subnet-0aa096f7b3f739d72]
aws_launch_configuration.ubuntu: Destroying... [id=possum_launch_20220315111821691000000001]
aws_launch_configuration.ubuntu: Destruction complete after 1s
aws_key_pair.ssh-key: Destroying... [id=ion-ssh-key-possum]
module.vpc.aws_security_group.sg-ubuntu: Destroying... [id=sg-0252e86a1349b3c42]
module.vpc.aws_subnet.subnet_private: Destruction complete after 1s
aws_key_pair.ssh-key: Destruction complete after 0s
tls_private_key.keys: Destroying... [id=4d0dc2ca17ee37787152e3a0c140b2749a014bad]
tls_private_key.keys: Destruction complete after 0s
module.vpc.aws_security_group.sg-ubuntu: Destruction complete after 0s
module.vpc.aws_vpc.vpc: Destroying... [id=vpc-0cba03045af90e3e5]
module.vpc.aws_vpc.vpc: Destruction complete after 0s
random_pet.suffix_name: Destroying... [id=possum]
random_pet.suffix_name: Destruction complete after 0s

Destroy complete! Resources: 12 destroyed.
```

