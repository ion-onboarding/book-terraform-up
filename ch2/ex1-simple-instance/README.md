# AWS ubuntu with terraform
- creates an ubuntu image and returns SSH details to login to it
- uses busy box to return a static web page on port 80

# How to use
If you didn't clone the repo yet, do that by accessing this [link](https://github.com/ion-onboarding/book-terraform-up) then return back here.\
Open shell and drive to `book-terraform-up/ch2/ex1-simple-instance`

## Create resources
```
terraform init
```
```
terraform apply -auto-approve
```

## Delete resources
```
terrafrom destroy -auto-approve
```

# Sample output: resources are created
```
terraform output
WWW = "http://13.51.160.47"
connect_SSH = "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.51.160.47"
```
```
$ curl 13.51.160.47
Hello, World
```

```
$ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.51.160.47
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.13.0-1017-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Fri Mar 11 15:06:41 UTC 2022

  System load:  0.0               Processes:             113
  Usage of /:   18.6% of 7.69GB   Users logged in:       0
  Memory usage: 20%               IPv4 address for ens5: 10.0.1.6
  Swap usage:   0%


1 update can be applied immediately.
To see these additional updates run: apt list --upgradable


Last login: Fri Mar 11 15:02:57 2022 from 77.162.168.171
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@ip-10-0-1-6:~$ exit
logout
Connection to 13.51.160.47 closed.
$
```

# Sample output terraform

## create resources
```
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/tls...
- Finding latest version of hashicorp/local...
- Finding hashicorp/aws versions matching "4.4.0"...
- Finding latest version of hashicorp/random...
- Installing hashicorp/local v2.2.2...
- Installed hashicorp/local v2.2.2 (signed by HashiCorp)
- Installing hashicorp/aws v4.4.0...
- Installed hashicorp/aws v4.4.0 (signed by HashiCorp)
- Installing hashicorp/random v3.1.0...
- Installed hashicorp/random v3.1.0 (signed by HashiCorp)
- Installing hashicorp/tls v3.1.0...
- Installed hashicorp/tls v3.1.0 (signed by HashiCorp)

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
$ terraform apply -auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.web will be created
  + resource "aws_instance" "web" {
      + ami                                  = "ami-04e4f9b92505045dd"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "ion-ubuntu"
        }
      + tags_all                             = {
          + "Name" = "ion-ubuntu"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "f656cd9de8860addc5a82630adc18c1b3a4883e5"
      + user_data_base64                     = (known after apply)
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id = (known after apply)
            }
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
          + instance_metadata_tags      = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_internet_gateway.gw will be created
  + resource "aws_internet_gateway" "gw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = (known after apply)
      + tags_all = (known after apply)
      + vpc_id   = (known after apply)
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

  # aws_route_table.route_table will be created
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

  # aws_route_table_association.a will be created
  + resource "aws_route_table_association" "a" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.web-server will be created
  + resource "aws_security_group" "web-server" {
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
      + name                   = "web-server"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = (known after apply)
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.subnet_web will be created
  + resource "aws_subnet" "subnet_web" {
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

  # aws_vpc.vpc will be created
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

Plan: 11 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + WWW         = (known after apply)
  + connect_SSH = (known after apply)
random_pet.suffix_name: Creating...
tls_private_key.keys: Creating...
random_pet.suffix_name: Creation complete after 0s [id=kingfish]
tls_private_key.keys: Creation complete after 0s [id=342461c25ab34fc3a1b6b8015805207bbfcc0c6e]
local_file.ssh-key-file: Creating...
local_file.ssh-key-file: Creation complete after 0s [id=c698541bd960b011b0fbc15ebc289b8d2a502aac]
aws_key_pair.ssh-key: Creating...
aws_vpc.vpc: Creating...
aws_key_pair.ssh-key: Creation complete after 0s [id=ion-ssh-key-kingfish]
aws_vpc.vpc: Still creating... [10s elapsed]
aws_vpc.vpc: Creation complete after 12s [id=vpc-0b241922615abc801]
aws_internet_gateway.gw: Creating...
aws_subnet.subnet_web: Creating...
aws_security_group.web-server: Creating...
aws_internet_gateway.gw: Creation complete after 0s [id=igw-0a94e8b60c8b280a5]
aws_route_table.route_table: Creating...
aws_subnet.subnet_web: Creation complete after 0s [id=subnet-04f4e66f6bf1cf73b]
aws_route_table.route_table: Creation complete after 1s [id=rtb-030556db7a40c8c97]
aws_route_table_association.a: Creating...
aws_route_table_association.a: Creation complete after 0s [id=rtbassoc-0e144857476bd1758]
aws_security_group.web-server: Creation complete after 2s [id=sg-0cc07e44587253a4a]
aws_instance.web: Creating...
aws_instance.web: Still creating... [10s elapsed]
aws_instance.web: Creation complete after 13s [id=i-0ee7f76ba0f4c294e]

Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

Outputs:

WWW = "http://13.51.160.47"
connect_SSH = "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.51.160.47"
```

## destroy resources
```
terraform destroy -auto-approve
random_pet.suffix_name: Refreshing state... [id=kingfish]
tls_private_key.keys: Refreshing state... [id=342461c25ab34fc3a1b6b8015805207bbfcc0c6e]
local_file.ssh-key-file: Refreshing state... [id=c698541bd960b011b0fbc15ebc289b8d2a502aac]
aws_key_pair.ssh-key: Refreshing state... [id=ion-ssh-key-kingfish]
aws_vpc.vpc: Refreshing state... [id=vpc-0b241922615abc801]
aws_internet_gateway.gw: Refreshing state... [id=igw-0a94e8b60c8b280a5]
aws_subnet.subnet_web: Refreshing state... [id=subnet-04f4e66f6bf1cf73b]
aws_security_group.web-server: Refreshing state... [id=sg-0cc07e44587253a4a]
aws_route_table.route_table: Refreshing state... [id=rtb-030556db7a40c8c97]
aws_route_table_association.a: Refreshing state... [id=rtbassoc-0e144857476bd1758]
aws_instance.web: Refreshing state... [id=i-0ee7f76ba0f4c294e]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_instance.web will be destroyed
  - resource "aws_instance" "web" {
      - ami                                  = "ami-04e4f9b92505045dd" -> null
      - arn                                  = "arn:aws:ec2:eu-north-1:267023797923:instance/i-0ee7f76ba0f4c294e" -> null
      - associate_public_ip_address          = true -> null
      - availability_zone                    = "eu-north-1b" -> null
      - cpu_core_count                       = 1 -> null
      - cpu_threads_per_core                 = 2 -> null
      - disable_api_termination              = false -> null
      - ebs_optimized                        = false -> null
      - get_password_data                    = false -> null
      - hibernation                          = false -> null
      - id                                   = "i-0ee7f76ba0f4c294e" -> null
      - instance_initiated_shutdown_behavior = "stop" -> null
      - instance_state                       = "running" -> null
      - instance_type                        = "t3.micro" -> null
      - ipv6_address_count                   = 0 -> null
      - ipv6_addresses                       = [] -> null
      - key_name                             = "ion-ssh-key-kingfish" -> null
      - monitoring                           = false -> null
      - primary_network_interface_id         = "eni-0e0307a320d908457" -> null
      - private_dns                          = "ip-10-0-1-6.eu-north-1.compute.internal" -> null
      - private_ip                           = "10.0.1.6" -> null
      - public_dns                           = "ec2-13-51-160-47.eu-north-1.compute.amazonaws.com" -> null
      - public_ip                            = "13.51.160.47" -> null
      - secondary_private_ips                = [] -> null
      - security_groups                      = [] -> null
      - source_dest_check                    = true -> null
      - subnet_id                            = "subnet-04f4e66f6bf1cf73b" -> null
      - tags                                 = {
          - "Name" = "ion-ubuntu"
        } -> null
      - tags_all                             = {
          - "Name" = "ion-ubuntu"
        } -> null
      - tenancy                              = "default" -> null
      - user_data                            = "f656cd9de8860addc5a82630adc18c1b3a4883e5" -> null
      - vpc_security_group_ids               = [
          - "sg-0cc07e44587253a4a",
        ] -> null

      - capacity_reservation_specification {
          - capacity_reservation_preference = "open" -> null
        }

      - credit_specification {
          - cpu_credits = "unlimited" -> null
        }

      - enclave_options {
          - enabled = false -> null
        }

      - metadata_options {
          - http_endpoint               = "enabled" -> null
          - http_put_response_hop_limit = 1 -> null
          - http_tokens                 = "optional" -> null
          - instance_metadata_tags      = "disabled" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - device_name           = "/dev/sda1" -> null
          - encrypted             = false -> null
          - iops                  = 100 -> null
          - tags                  = {} -> null
          - throughput            = 0 -> null
          - volume_id             = "vol-019a19e37a020fb8b" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp2" -> null
        }
    }

  # aws_internet_gateway.gw will be destroyed
  - resource "aws_internet_gateway" "gw" {
      - arn      = "arn:aws:ec2:eu-north-1:267023797923:internet-gateway/igw-0a94e8b60c8b280a5" -> null
      - id       = "igw-0a94e8b60c8b280a5" -> null
      - owner_id = "267023797923" -> null
      - tags     = {
          - "Name" = "ion-gw-kingfish"
        } -> null
      - tags_all = {
          - "Name" = "ion-gw-kingfish"
        } -> null
      - vpc_id   = "vpc-0b241922615abc801" -> null
    }

  # aws_key_pair.ssh-key will be destroyed
  - resource "aws_key_pair" "ssh-key" {
      - arn         = "arn:aws:ec2:eu-north-1:267023797923:key-pair/ion-ssh-key-kingfish" -> null
      - fingerprint = "49:da:b7:3f:ea:18:59:3f:52:5b:4f:b1:00:e7:f9:8e" -> null
      - id          = "ion-ssh-key-kingfish" -> null
      - key_name    = "ion-ssh-key-kingfish" -> null
      - key_pair_id = "key-0c6c7b69e31964153" -> null
      - public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDXetltDnkgQ7ynX+y7liQnE9CLzL/psJ0e3Q9ZYwRb2ibnoC7eercKyMgnNa8ElnJDeQ1uu6J9bgucxiC6UtRWxBjRCxeCHcnrJJSMuRez4tEdZy7wKqcOhCVgpveJcpct+XG8NB5IhesPlKdsrAe2VDhvAQIbO0xIDJQ3qiwZxgUCGPoisZ2ArTndvQglevl7MGJ4dgRSEmDqVICtv7HP9B5J0AwIkZnyE8LAPmQStQc1Z9E4xfe43Dw7an28/sjNmEtH0LKs/HSNeYN6sNiMefhmrzHHKx49yE8CJEI9WMA9hrF/U8FO7e8YFQXTMCk5Ei3G1VzIkywgGg9iW41F" -> null
      - tags        = {
          - "Name" = "ion-key-pair-kingfish"
        } -> null
      - tags_all    = {
          - "Name" = "ion-key-pair-kingfish"
        } -> null
    }

  # aws_route_table.route_table will be destroyed
  - resource "aws_route_table" "route_table" {
      - arn              = "arn:aws:ec2:eu-north-1:267023797923:route-table/rtb-030556db7a40c8c97" -> null
      - id               = "rtb-030556db7a40c8c97" -> null
      - owner_id         = "267023797923" -> null
      - propagating_vgws = [] -> null
      - route            = [
          - {
              - carrier_gateway_id         = ""
              - cidr_block                 = "0.0.0.0/0"
              - destination_prefix_list_id = ""
              - egress_only_gateway_id     = ""
              - gateway_id                 = "igw-0a94e8b60c8b280a5"
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
          - "Name" = "ion-route-table-kingfish"
        } -> null
      - tags_all         = {
          - "Name" = "ion-route-table-kingfish"
        } -> null
      - vpc_id           = "vpc-0b241922615abc801" -> null
    }

  # aws_route_table_association.a will be destroyed
  - resource "aws_route_table_association" "a" {
      - id             = "rtbassoc-0e144857476bd1758" -> null
      - route_table_id = "rtb-030556db7a40c8c97" -> null
      - subnet_id      = "subnet-04f4e66f6bf1cf73b" -> null
    }

  # aws_security_group.web-server will be destroyed
  - resource "aws_security_group" "web-server" {
      - arn                    = "arn:aws:ec2:eu-north-1:267023797923:security-group/sg-0cc07e44587253a4a" -> null
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
      - id                     = "sg-0cc07e44587253a4a" -> null
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
      - name                   = "web-server" -> null
      - owner_id               = "267023797923" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {
          - "Name" = "ion-web-server-kingfish"
        } -> null
      - tags_all               = {
          - "Name" = "ion-web-server-kingfish"
        } -> null
      - vpc_id                 = "vpc-0b241922615abc801" -> null
    }

  # aws_subnet.subnet_web will be destroyed
  - resource "aws_subnet" "subnet_web" {
      - arn                                            = "arn:aws:ec2:eu-north-1:267023797923:subnet/subnet-04f4e66f6bf1cf73b" -> null
      - assign_ipv6_address_on_creation                = false -> null
      - availability_zone                              = "eu-north-1b" -> null
      - availability_zone_id                           = "eun1-az2" -> null
      - cidr_block                                     = "10.0.1.0/24" -> null
      - enable_dns64                                   = false -> null
      - enable_resource_name_dns_a_record_on_launch    = false -> null
      - enable_resource_name_dns_aaaa_record_on_launch = false -> null
      - id                                             = "subnet-04f4e66f6bf1cf73b" -> null
      - ipv6_native                                    = false -> null
      - map_customer_owned_ip_on_launch                = false -> null
      - map_public_ip_on_launch                        = false -> null
      - owner_id                                       = "267023797923" -> null
      - private_dns_hostname_type_on_launch            = "ip-name" -> null
      - tags                                           = {
          - "Name" = "ion-subnet-kingfish"
        } -> null
      - tags_all                                       = {
          - "Name" = "ion-subnet-kingfish"
        } -> null
      - vpc_id                                         = "vpc-0b241922615abc801" -> null
    }

  # aws_vpc.vpc will be destroyed
  - resource "aws_vpc" "vpc" {
      - arn                              = "arn:aws:ec2:eu-north-1:267023797923:vpc/vpc-0b241922615abc801" -> null
      - assign_generated_ipv6_cidr_block = false -> null
      - cidr_block                       = "10.0.0.0/16" -> null
      - default_network_acl_id           = "acl-0e3791824b76015d4" -> null
      - default_route_table_id           = "rtb-0dbc48608768819d2" -> null
      - default_security_group_id        = "sg-0f40a44c0971dcbe4" -> null
      - dhcp_options_id                  = "dopt-c560cdac" -> null
      - enable_classiclink               = false -> null
      - enable_classiclink_dns_support   = false -> null
      - enable_dns_hostnames             = true -> null
      - enable_dns_support               = true -> null
      - id                               = "vpc-0b241922615abc801" -> null
      - instance_tenancy                 = "default" -> null
      - ipv6_netmask_length              = 0 -> null
      - main_route_table_id              = "rtb-0dbc48608768819d2" -> null
      - owner_id                         = "267023797923" -> null
      - tags                             = {
          - "Name" = "ion-vpc-kingfish"
        } -> null
      - tags_all                         = {
          - "Name" = "ion-vpc-kingfish"
        } -> null
    }

  # local_file.ssh-key-file will be destroyed
  - resource "local_file" "ssh-key-file" {
      - content              = (sensitive) -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0600" -> null
      - filename             = "./artifacts/id_rsa.priv" -> null
      - id                   = "c698541bd960b011b0fbc15ebc289b8d2a502aac" -> null
    }

  # random_pet.suffix_name will be destroyed
  - resource "random_pet" "suffix_name" {
      - id        = "kingfish" -> null
      - length    = 1 -> null
      - separator = "-" -> null
    }

  # tls_private_key.keys will be destroyed
  - resource "tls_private_key" "keys" {
      - algorithm                  = "RSA" -> null
      - ecdsa_curve                = "P224" -> null
      - id                         = "342461c25ab34fc3a1b6b8015805207bbfcc0c6e" -> null
      - private_key_pem            = (sensitive value)
      - public_key_fingerprint_md5 = "11:5d:91:17:1c:84:21:ee:54:9f:4e:a3:4f:71:fa:fe" -> null
      - public_key_openssh         = <<-EOT
            ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDXetltDnkgQ7ynX+y7liQnE9CLzL/psJ0e3Q9ZYwRb2ibnoC7eercKyMgnNa8ElnJDeQ1uu6J9bgucxiC6UtRWxBjRCxeCHcnrJJSMuRez4tEdZy7wKqcOhCVgpveJcpct+XG8NB5IhesPlKdsrAe2VDhvAQIbO0xIDJQ3qiwZxgUCGPoisZ2ArTndvQglevl7MGJ4dgRSEmDqVICtv7HP9B5J0AwIkZnyE8LAPmQStQc1Z9E4xfe43Dw7an28/sjNmEtH0LKs/HSNeYN6sNiMefhmrzHHKx49yE8CJEI9WMA9hrF/U8FO7e8YFQXTMCk5Ei3G1VzIkywgGg9iW41F
        EOT -> null
      - public_key_pem             = <<-EOT
            -----BEGIN PUBLIC KEY-----
            MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA13rZbQ55IEO8p1/su5Yk
            JxPQi8y/6bCdHt0PWWMEW9om56Au3nq3CsjIJzWvBJZyQ3kNbruifW4LnMYgulLU
            VsQY0QsXgh3J6ySUjLkXs+LRHWcu8CqnDoQlYKb3iXKXLflxvDQeSIXrD5SnbKwH
            tlQ4bwECGztMSAyUN6osGcYFAhj6IrGdgK053b0IJXr5ezBieHYEUhJg6lSArb+x
            z/QeSdAMCJGZ8hPCwD5kErUHNWfROMX3uNw8O2p9vP7IzZhLR9CyrPx0jXmDerDY
            jHn4Zq8xxysePchPAiRCPVjAPYaxf1PBTu3vGBUF0zApORItxtVcyJMsIBoPYluN
            RQIDAQAB
            -----END PUBLIC KEY-----
        EOT -> null
      - rsa_bits                   = 2048 -> null
    }

Plan: 0 to add, 0 to change, 11 to destroy.

Changes to Outputs:
  - WWW         = "http://13.51.160.47" -> null
  - connect_SSH = "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.51.160.47" -> null
local_file.ssh-key-file: Destroying... [id=c698541bd960b011b0fbc15ebc289b8d2a502aac]
local_file.ssh-key-file: Destruction complete after 0s
aws_route_table_association.a: Destroying... [id=rtbassoc-0e144857476bd1758]
aws_instance.web: Destroying... [id=i-0ee7f76ba0f4c294e]
aws_route_table_association.a: Destruction complete after 0s
aws_route_table.route_table: Destroying... [id=rtb-030556db7a40c8c97]
aws_route_table.route_table: Destruction complete after 1s
aws_internet_gateway.gw: Destroying... [id=igw-0a94e8b60c8b280a5]
aws_instance.web: Still destroying... [id=i-0ee7f76ba0f4c294e, 10s elapsed]
aws_internet_gateway.gw: Still destroying... [id=igw-0a94e8b60c8b280a5, 10s elapsed]
aws_instance.web: Still destroying... [id=i-0ee7f76ba0f4c294e, 20s elapsed]
aws_internet_gateway.gw: Still destroying... [id=igw-0a94e8b60c8b280a5, 20s elapsed]
aws_internet_gateway.gw: Destruction complete after 27s
aws_instance.web: Still destroying... [id=i-0ee7f76ba0f4c294e, 30s elapsed]
aws_instance.web: Still destroying... [id=i-0ee7f76ba0f4c294e, 40s elapsed]
aws_instance.web: Destruction complete after 40s
aws_key_pair.ssh-key: Destroying... [id=ion-ssh-key-kingfish]
aws_subnet.subnet_web: Destroying... [id=subnet-04f4e66f6bf1cf73b]
aws_security_group.web-server: Destroying... [id=sg-0cc07e44587253a4a]
aws_key_pair.ssh-key: Destruction complete after 0s
tls_private_key.keys: Destroying... [id=342461c25ab34fc3a1b6b8015805207bbfcc0c6e]
tls_private_key.keys: Destruction complete after 0s
aws_subnet.subnet_web: Destruction complete after 1s
aws_security_group.web-server: Destruction complete after 1s
aws_vpc.vpc: Destroying... [id=vpc-0b241922615abc801]
aws_vpc.vpc: Destruction complete after 0s
random_pet.suffix_name: Destroying... [id=kingfish]
random_pet.suffix_name: Destruction complete after 0s

Destroy complete! Resources: 11 destroyed.
```
