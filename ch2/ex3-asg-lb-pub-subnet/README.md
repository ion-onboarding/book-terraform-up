# AWS ubuntu with terraform
- creates AWS ASG (auto scaling group) with 2 ubuntu images on 2 public subnets
- LoadBalancer will forward HTTP to ubuntu servers, running busybox httpd
- SSH and LB-URL are exposed for easy access

# How to use
If you didn't clone the repo yet, do that by accessing this [link](https://github.com/ion-onboarding/book-terraform-up) then return back here.\
Open a shell and drive to:
```
cd ch2/ex2-asg-lb-pub-subnet
```

# Create resources
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

If ASG scaled in or scaled out do another terraform apply to output SSH connection details.


# Delete resources
```
terraform destroy -auto-approve
```

# Sample output: resources are created
```
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/tls...
- Finding latest version of hashicorp/random...
- Finding latest version of hashicorp/local...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/tls v3.1.0...
- Installed hashicorp/tls v3.1.0 (signed by HashiCorp)
- Installing hashicorp/random v3.1.1...
- Installed hashicorp/random v3.1.1 (signed by HashiCorp)
- Installing hashicorp/local v2.2.2...
- Installed hashicorp/local v2.2.2 (signed by HashiCorp)
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

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated
with the following symbols:
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

  # aws_autoscaling_attachment.asg-ubuntu will be created
  + resource "aws_autoscaling_attachment" "asg-ubuntu" {
      + autoscaling_group_name = (known after apply)
      + id                     = (known after apply)
      + lb_target_group_arn    = (known after apply)
    }

  # aws_autoscaling_group.ubuntu will be created
  + resource "aws_autoscaling_group" "ubuntu" {
      + arn                       = (known after apply)
      + availability_zones        = (known after apply)
      + default_cooldown          = (known after apply)
      + desired_capacity          = 2
      + force_delete              = false
      + force_delete_warm_pool    = false
      + health_check_grace_period = 300
      + health_check_type         = (known after apply)
      + id                        = (known after apply)
      + launch_configuration      = (known after apply)
      + max_size                  = 3
      + metrics_granularity       = "1Minute"
      + min_size                  = 2
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
      + user_data                   = "9240bafb21fdba959ffde6c874c0ec171acce20f"

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

  # aws_lb.load-balancer will be created
  + resource "aws_lb" "load-balancer" {
      + arn                        = (known after apply)
      + arn_suffix                 = (known after apply)
      + desync_mitigation_mode     = "defensive"
      + dns_name                   = (known after apply)
      + drop_invalid_header_fields = false
      + enable_deletion_protection = false
      + enable_http2               = true
      + enable_waf_fail_open       = false
      + id                         = (known after apply)
      + idle_timeout               = 60
      + internal                   = false
      + ip_address_type            = (known after apply)
      + load_balancer_type         = "application"
      + name                       = "load-balancer"
      + security_groups            = (known after apply)
      + subnets                    = (known after apply)
      + tags                       = (known after apply)
      + tags_all                   = (known after apply)
      + vpc_id                     = (known after apply)
      + zone_id                    = (known after apply)

      + subnet_mapping {
          + allocation_id        = (known after apply)
          + ipv6_address         = (known after apply)
          + outpost_id           = (known after apply)
          + private_ipv4_address = (known after apply)
          + subnet_id            = (known after apply)
        }
    }

  # aws_lb_listener.listen-HTTP will be created
  + resource "aws_lb_listener" "listen-HTTP" {
      + arn               = (known after apply)
      + id                = (known after apply)
      + load_balancer_arn = (known after apply)
      + port              = 80
      + protocol          = "HTTP"
      + ssl_policy        = (known after apply)
      + tags_all          = (known after apply)

      + default_action {
          + order            = (known after apply)
          + target_group_arn = (known after apply)
          + type             = "forward"
        }
    }

  # aws_lb_target_group.target-group-asg-ubuntu will be created
  + resource "aws_lb_target_group" "target-group-asg-ubuntu" {
      + arn                                = (known after apply)
      + arn_suffix                         = (known after apply)
      + connection_termination             = false
      + deregistration_delay               = "300"
      + id                                 = (known after apply)
      + lambda_multi_value_headers_enabled = false
      + load_balancing_algorithm_type      = (known after apply)
      + name                               = "target-asg-ubuntu"
      + port                               = 80
      + preserve_client_ip                 = (known after apply)
      + protocol                           = "HTTP"
      + protocol_version                   = (known after apply)
      + proxy_protocol_v2                  = false
      + slow_start                         = 0
      + tags_all                           = (known after apply)
      + target_type                        = "instance"
      + vpc_id                             = (known after apply)

      + health_check {
          + enabled             = (known after apply)
          + healthy_threshold   = (known after apply)
          + interval            = (known after apply)
          + matcher             = (known after apply)
          + path                = (known after apply)
          + port                = (known after apply)
          + protocol            = (known after apply)
          + timeout             = (known after apply)
          + unhealthy_threshold = (known after apply)
        }

      + stickiness {
          + cookie_duration = (known after apply)
          + cookie_name     = (known after apply)
          + enabled         = (known after apply)
          + type            = (known after apply)
        }
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

  # aws_route_table_association.b will be created
  + resource "aws_route_table_association" "b" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.sg-load-balancer will be created
  + resource "aws_security_group" "sg-load-balancer" {
      + arn                    = (known after apply)
      + description            = "allow HTTP"
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
      + name                   = "load-loadbalancer"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = (known after apply)
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.sg-ubuntu will be created
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
              + security_groups  = (known after apply)
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
              + cidr_blocks      = []
              + description      = "Enter WEB"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = (known after apply)
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "server-ubuntu"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = (known after apply)
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.subnet_pub_a will be created
  + resource "aws_subnet" "subnet_pub_a" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "eu-north-1a"
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

  # aws_subnet.subnet_pub_b will be created
  + resource "aws_subnet" "subnet_pub_b" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "eu-north-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.2.0/24"
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

Plan: 19 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + access_LB_HTTP = (known after apply)
  + access_SSH     = (known after apply)
tls_private_key.keys: Creating...
random_pet.suffix_name: Creating...
random_pet.suffix_name: Creation complete after 0s [id=mammal]
tls_private_key.keys: Creation complete after 0s [id=41e138279f526fdc9c490ee1a9f8a087029c9b1c]
local_file.ssh-key-file: Creating...
local_file.ssh-key-file: Creation complete after 0s [id=e71e1c8795ffd24cc99d09c5ac909b64a87af2c2]
aws_key_pair.ssh-key: Creating...
aws_vpc.vpc: Creating...
aws_key_pair.ssh-key: Creation complete after 0s [id=ssh-key-mammal]
aws_vpc.vpc: Still creating... [10s elapsed]
aws_vpc.vpc: Creation complete after 12s [id=vpc-08533456a3fdf61a6]
aws_internet_gateway.gw: Creating...
aws_subnet.subnet_pub_b: Creating...
aws_subnet.subnet_pub_a: Creating...
aws_lb_target_group.target-group-asg-ubuntu: Creating...
aws_security_group.sg-load-balancer: Creating...
aws_internet_gateway.gw: Creation complete after 0s [id=igw-050bad77d10e610d1]
aws_route_table.route_table: Creating...
aws_lb_target_group.target-group-asg-ubuntu: Creation complete after 0s [id=arn:aws:elasticloadbalancing:eu-north-1:267023797923:targetgroup/target-asg-ubuntu/552bcb6e96576c60]
aws_subnet.subnet_pub_a: Creation complete after 0s [id=subnet-03ff0eaa232547f1b]
aws_subnet.subnet_pub_b: Creation complete after 0s [id=subnet-02d6b865b7df047a2]
aws_route_table.route_table: Creation complete after 1s [id=rtb-033c38610cffe7878]
aws_route_table_association.b: Creating...
aws_route_table_association.a: Creating...
aws_route_table_association.b: Creation complete after 0s [id=rtbassoc-0c46ed595b22cac0c]
aws_route_table_association.a: Creation complete after 0s [id=rtbassoc-0cd841f2e3ebb1c48]
aws_security_group.sg-load-balancer: Creation complete after 2s [id=sg-0bb74eeee245e89c4]
aws_lb.load-balancer: Creating...
aws_security_group.sg-ubuntu: Creating...
aws_security_group.sg-ubuntu: Creation complete after 2s [id=sg-0522595f2951594e9]
aws_launch_configuration.ubuntu: Creating...
aws_launch_configuration.ubuntu: Creation complete after 1s [id=mammal_launch_20220317121532091600000001]
aws_autoscaling_group.ubuntu: Creating...
aws_lb.load-balancer: Still creating... [10s elapsed]
aws_autoscaling_group.ubuntu: Still creating... [10s elapsed]
aws_lb.load-balancer: Still creating... [20s elapsed]
aws_autoscaling_group.ubuntu: Still creating... [20s elapsed]
aws_autoscaling_group.ubuntu: Creation complete after 27s [id=terraform-20220317121532658400000002]
data.aws_instances.asg-instances: Reading...
aws_autoscaling_attachment.asg-ubuntu: Creating...
data.aws_instances.asg-instances: Read complete after 0s [id=eu-north-1]
aws_autoscaling_attachment.asg-ubuntu: Creation complete after 0s [id=terraform-20220317121532658400000002-20220317121559913000000003]
aws_lb.load-balancer: Still creating... [30s elapsed]
aws_lb.load-balancer: Still creating... [40s elapsed]
aws_lb.load-balancer: Still creating... [50s elapsed]
aws_lb.load-balancer: Still creating... [1m0s elapsed]
aws_lb.load-balancer: Still creating... [1m10s elapsed]
aws_lb.load-balancer: Still creating... [1m20s elapsed]
aws_lb.load-balancer: Still creating... [1m30s elapsed]
aws_lb.load-balancer: Still creating... [1m40s elapsed]
aws_lb.load-balancer: Still creating... [1m50s elapsed]
aws_lb.load-balancer: Still creating... [2m0s elapsed]
aws_lb.load-balancer: Still creating... [2m10s elapsed]
aws_lb.load-balancer: Still creating... [2m20s elapsed]
aws_lb.load-balancer: Still creating... [2m30s elapsed]
aws_lb.load-balancer: Still creating... [2m40s elapsed]
aws_lb.load-balancer: Still creating... [2m50s elapsed]
aws_lb.load-balancer: Creation complete after 2m52s [id=arn:aws:elasticloadbalancing:eu-north-1:267023797923:loadbalancer/app/load-balancer/c2536886bff5d339]
aws_lb_listener.listen-HTTP: Creating...
aws_lb_listener.listen-HTTP: Creation complete after 0s [id=arn:aws:elasticloadbalancing:eu-north-1:267023797923:listener/app/load-balancer/c2536886bff5d339/06ae54b9c44aa1b4]

Apply complete! Resources: 19 added, 0 changed, 0 destroyed.

Outputs:

access_LB_HTTP = "http://load-balancer-216394804.eu-north-1.elb.amazonaws.com"
access_SSH = tolist([
  "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.51.108.241",
  "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@16.170.234.111",
])
```

# Sample output: resources are destroyed
```
terraform destroy -auto-approve
random_pet.suffix_name: Refreshing state... [id=mammal]
tls_private_key.keys: Refreshing state... [id=41e138279f526fdc9c490ee1a9f8a087029c9b1c]
local_file.ssh-key-file: Refreshing state... [id=e71e1c8795ffd24cc99d09c5ac909b64a87af2c2]
aws_key_pair.ssh-key: Refreshing state... [id=ssh-key-mammal]
aws_vpc.vpc: Refreshing state... [id=vpc-08533456a3fdf61a6]
aws_internet_gateway.gw: Refreshing state... [id=igw-050bad77d10e610d1]
aws_subnet.subnet_pub_b: Refreshing state... [id=subnet-02d6b865b7df047a2]
aws_subnet.subnet_pub_a: Refreshing state... [id=subnet-03ff0eaa232547f1b]
aws_security_group.sg-load-balancer: Refreshing state... [id=sg-0bb74eeee245e89c4]
aws_lb_target_group.target-group-asg-ubuntu: Refreshing state... [id=arn:aws:elasticloadbalancing:eu-north-1:267023797923:targetgroup/target-asg-ubuntu/552bcb6e96576c60]
aws_route_table.route_table: Refreshing state... [id=rtb-033c38610cffe7878]
aws_security_group.sg-ubuntu: Refreshing state... [id=sg-0522595f2951594e9]
aws_route_table_association.b: Refreshing state... [id=rtbassoc-0c46ed595b22cac0c]
aws_route_table_association.a: Refreshing state... [id=rtbassoc-0cd841f2e3ebb1c48]
aws_lb.load-balancer: Refreshing state... [id=arn:aws:elasticloadbalancing:eu-north-1:267023797923:loadbalancer/app/load-balancer/c2536886bff5d339]
aws_launch_configuration.ubuntu: Refreshing state... [id=mammal_launch_20220317121532091600000001]
aws_lb_listener.listen-HTTP: Refreshing state... [id=arn:aws:elasticloadbalancing:eu-north-1:267023797923:listener/app/load-balancer/c2536886bff5d339/06ae54b9c44aa1b4]
aws_autoscaling_group.ubuntu: Refreshing state... [id=terraform-20220317121532658400000002]
aws_autoscaling_attachment.asg-ubuntu: Refreshing state... [id=terraform-20220317121532658400000002-20220317121559913000000003]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_autoscaling_attachment.asg-ubuntu will be destroyed
  - resource "aws_autoscaling_attachment" "asg-ubuntu" {
      - autoscaling_group_name = "terraform-20220317121532658400000002" -> null
      - id                     = "terraform-20220317121532658400000002-20220317121559913000000003" -> null
      - lb_target_group_arn    = "arn:aws:elasticloadbalancing:eu-north-1:267023797923:targetgroup/target-asg-ubuntu/552bcb6e96576c60" -> null
    }

  # aws_autoscaling_group.ubuntu will be destroyed
  - resource "aws_autoscaling_group" "ubuntu" {
      - arn                       = "arn:aws:autoscaling:eu-north-1:267023797923:autoScalingGroup:ae4f3010-3b54-4106-87c7-ff7acaa38a03:autoScalingGroupName/terraform-20220317121532658400000002" -> null
      - availability_zones        = [
          - "eu-north-1a",
        ] -> null
      - capacity_rebalance        = false -> null
      - default_cooldown          = 300 -> null
      - desired_capacity          = 2 -> null
      - enabled_metrics           = [] -> null
      - force_delete              = false -> null
      - force_delete_warm_pool    = false -> null
      - health_check_grace_period = 300 -> null
      - health_check_type         = "EC2" -> null
      - id                        = "terraform-20220317121532658400000002" -> null
      - launch_configuration      = "mammal_launch_20220317121532091600000001" -> null
      - load_balancers            = [] -> null
      - max_instance_lifetime     = 0 -> null
      - max_size                  = 3 -> null
      - metrics_granularity       = "1Minute" -> null
      - min_size                  = 2 -> null
      - name                      = "terraform-20220317121532658400000002" -> null
      - name_prefix               = "terraform-" -> null
      - protect_from_scale_in     = false -> null
      - service_linked_role_arn   = "arn:aws:iam::267023797923:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling" -> null
      - suspended_processes       = [] -> null
      - target_group_arns         = [
          - "arn:aws:elasticloadbalancing:eu-north-1:267023797923:targetgroup/target-asg-ubuntu/552bcb6e96576c60",
        ] -> null
      - termination_policies      = [] -> null
      - vpc_zone_identifier       = [
          - "subnet-03ff0eaa232547f1b",
        ] -> null
      - wait_for_capacity_timeout = "10m" -> null

      - tag {
          - key                 = "Name" -> null
          - propagate_at_launch = true -> null
          - value               = "mammal_asg-ubuntu_" -> null
        }
    }

  # aws_internet_gateway.gw will be destroyed
  - resource "aws_internet_gateway" "gw" {
      - arn      = "arn:aws:ec2:eu-north-1:267023797923:internet-gateway/igw-050bad77d10e610d1" -> null
      - id       = "igw-050bad77d10e610d1" -> null
      - owner_id = "267023797923" -> null
      - tags     = {
          - "Name" = "gw-mammal"
        } -> null
      - tags_all = {
          - "Name" = "gw-mammal"
        } -> null
      - vpc_id   = "vpc-08533456a3fdf61a6" -> null
    }

  # aws_key_pair.ssh-key will be destroyed
  - resource "aws_key_pair" "ssh-key" {
      - arn         = "arn:aws:ec2:eu-north-1:267023797923:key-pair/ssh-key-mammal" -> null
      - fingerprint = "dc:8b:30:83:b7:ed:14:50:3d:a2:62:15:40:59:f0:77" -> null
      - id          = "ssh-key-mammal" -> null
      - key_name    = "ssh-key-mammal" -> null
      - key_pair_id = "key-0697d790db0185d3a" -> null
      - public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDe5L71SxBYntRT7xYrMhK4nGCyBLGJPNINDq4TsusLjI3bqPP0o8XehYKJQkf+0a/qe+ft+QE7iwBSFSV+ID2QUevGMehA5plTHIkjNs6f07UA2+dNkSEbH5a/X2cf5VJ3HMqjxQhKIiGgukjjTn1Mo7di58wfzyq3qjXo/X+KIxMJanp+/YosUJSC5BL7Lz78ZUrIg98X8I/OW5L+4AFg83E+svVKeMTwG8hWZ+yOtGu2yTwKBJia2QmunPtIavYzgy8LPQQbpGNSitrJ3s8dc0QRItambuyU4d3iAiiXhk2E58S6CItx90Foc8QV2ZRWPXNpJ2P49BseInpSjM9H" -> null
      - tags        = {
          - "Name" = "key-pair-mammal"
        } -> null
      - tags_all    = {
          - "Name" = "key-pair-mammal"
        } -> null
    }

  # aws_launch_configuration.ubuntu will be destroyed
  - resource "aws_launch_configuration" "ubuntu" {
      - arn                              = "arn:aws:autoscaling:eu-north-1:267023797923:launchConfiguration:25bc72c9-f07c-47cd-80a8-15891f916267:launchConfigurationName/mammal_launch_20220317121532091600000001" -> null
      - associate_public_ip_address      = true -> null
      - ebs_optimized                    = false -> null
      - enable_monitoring                = true -> null
      - id                               = "mammal_launch_20220317121532091600000001" -> null
      - image_id                         = "ami-04e4f9b92505045dd" -> null
      - instance_type                    = "t3.micro" -> null
      - key_name                         = "ssh-key-mammal" -> null
      - name                             = "mammal_launch_20220317121532091600000001" -> null
      - name_prefix                      = "mammal_launch_" -> null
      - security_groups                  = [
          - "sg-0522595f2951594e9",
        ] -> null
      - user_data                        = "9240bafb21fdba959ffde6c874c0ec171acce20f" -> null
      - vpc_classic_link_security_groups = [] -> null
    }

  # aws_lb.load-balancer will be destroyed
  - resource "aws_lb" "load-balancer" {
      - arn                        = "arn:aws:elasticloadbalancing:eu-north-1:267023797923:loadbalancer/app/load-balancer/c2536886bff5d339" -> null
      - arn_suffix                 = "app/load-balancer/c2536886bff5d339" -> null
      - desync_mitigation_mode     = "defensive" -> null
      - dns_name                   = "load-balancer-216394804.eu-north-1.elb.amazonaws.com" -> null
      - drop_invalid_header_fields = false -> null
      - enable_deletion_protection = false -> null
      - enable_http2               = true -> null
      - enable_waf_fail_open       = false -> null
      - id                         = "arn:aws:elasticloadbalancing:eu-north-1:267023797923:loadbalancer/app/load-balancer/c2536886bff5d339" -> null
      - idle_timeout               = 60 -> null
      - internal                   = false -> null
      - ip_address_type            = "ipv4" -> null
      - load_balancer_type         = "application" -> null
      - name                       = "load-balancer" -> null
      - security_groups            = [
          - "sg-0bb74eeee245e89c4",
        ] -> null
      - subnets                    = [
          - "subnet-02d6b865b7df047a2",
          - "subnet-03ff0eaa232547f1b",
        ] -> null
      - tags                       = {
          - "Name" = "key-pair-mammal"
        } -> null
      - tags_all                   = {
          - "Name" = "key-pair-mammal"
        } -> null
      - vpc_id                     = "vpc-08533456a3fdf61a6" -> null
      - zone_id                    = "Z23TAZ6LKFMNIO" -> null

      - access_logs {
          - enabled = false -> null
        }

      - subnet_mapping {
          - subnet_id = "subnet-02d6b865b7df047a2" -> null
        }
      - subnet_mapping {
          - subnet_id = "subnet-03ff0eaa232547f1b" -> null
        }
    }

  # aws_lb_listener.listen-HTTP will be destroyed
  - resource "aws_lb_listener" "listen-HTTP" {
      - arn               = "arn:aws:elasticloadbalancing:eu-north-1:267023797923:listener/app/load-balancer/c2536886bff5d339/06ae54b9c44aa1b4" -> null
      - id                = "arn:aws:elasticloadbalancing:eu-north-1:267023797923:listener/app/load-balancer/c2536886bff5d339/06ae54b9c44aa1b4" -> null
      - load_balancer_arn = "arn:aws:elasticloadbalancing:eu-north-1:267023797923:loadbalancer/app/load-balancer/c2536886bff5d339" -> null
      - port              = 80 -> null
      - protocol          = "HTTP" -> null
      - tags              = {} -> null
      - tags_all          = {} -> null

      - default_action {
          - order            = 1 -> null
          - target_group_arn = "arn:aws:elasticloadbalancing:eu-north-1:267023797923:targetgroup/target-asg-ubuntu/552bcb6e96576c60" -> null
          - type             = "forward" -> null
        }
    }

  # aws_lb_target_group.target-group-asg-ubuntu will be destroyed
  - resource "aws_lb_target_group" "target-group-asg-ubuntu" {
      - arn                                = "arn:aws:elasticloadbalancing:eu-north-1:267023797923:targetgroup/target-asg-ubuntu/552bcb6e96576c60" -> null
      - arn_suffix                         = "targetgroup/target-asg-ubuntu/552bcb6e96576c60" -> null
      - connection_termination             = false -> null
      - deregistration_delay               = "300" -> null
      - id                                 = "arn:aws:elasticloadbalancing:eu-north-1:267023797923:targetgroup/target-asg-ubuntu/552bcb6e96576c60" -> null
      - lambda_multi_value_headers_enabled = false -> null
      - load_balancing_algorithm_type      = "round_robin" -> null
      - name                               = "target-asg-ubuntu" -> null
      - port                               = 80 -> null
      - protocol                           = "HTTP" -> null
      - protocol_version                   = "HTTP1" -> null
      - proxy_protocol_v2                  = false -> null
      - slow_start                         = 0 -> null
      - tags                               = {} -> null
      - tags_all                           = {} -> null
      - target_type                        = "instance" -> null
      - vpc_id                             = "vpc-08533456a3fdf61a6" -> null

      - health_check {
          - enabled             = true -> null
          - healthy_threshold   = 5 -> null
          - interval            = 30 -> null
          - matcher             = "200" -> null
          - path                = "/" -> null
          - port                = "traffic-port" -> null
          - protocol            = "HTTP" -> null
          - timeout             = 5 -> null
          - unhealthy_threshold = 2 -> null
        }

      - stickiness {
          - cookie_duration = 86400 -> null
          - enabled         = false -> null
          - type            = "lb_cookie" -> null
        }
    }

  # aws_route_table.route_table will be destroyed
  - resource "aws_route_table" "route_table" {
      - arn              = "arn:aws:ec2:eu-north-1:267023797923:route-table/rtb-033c38610cffe7878" -> null
      - id               = "rtb-033c38610cffe7878" -> null
      - owner_id         = "267023797923" -> null
      - propagating_vgws = [] -> null
      - route            = [
          - {
              - carrier_gateway_id         = ""
              - cidr_block                 = "0.0.0.0/0"
              - destination_prefix_list_id = ""
              - egress_only_gateway_id     = ""
              - gateway_id                 = "igw-050bad77d10e610d1"
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
          - "Name" = "route-table-mammal"
        } -> null
      - tags_all         = {
          - "Name" = "route-table-mammal"
        } -> null
      - vpc_id           = "vpc-08533456a3fdf61a6" -> null
    }

  # aws_route_table_association.a will be destroyed
  - resource "aws_route_table_association" "a" {
      - id             = "rtbassoc-0cd841f2e3ebb1c48" -> null
      - route_table_id = "rtb-033c38610cffe7878" -> null
      - subnet_id      = "subnet-03ff0eaa232547f1b" -> null
    }

  # aws_route_table_association.b will be destroyed
  - resource "aws_route_table_association" "b" {
      - id             = "rtbassoc-0c46ed595b22cac0c" -> null
      - route_table_id = "rtb-033c38610cffe7878" -> null
      - subnet_id      = "subnet-02d6b865b7df047a2" -> null
    }

  # aws_security_group.sg-load-balancer will be destroyed
  - resource "aws_security_group" "sg-load-balancer" {
      - arn                    = "arn:aws:ec2:eu-north-1:267023797923:security-group/sg-0bb74eeee245e89c4" -> null
      - description            = "allow HTTP" -> null
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
      - id                     = "sg-0bb74eeee245e89c4" -> null
      - ingress                = [
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
      - name                   = "load-loadbalancer" -> null
      - owner_id               = "267023797923" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {
          - "Name" = "sg-load-balancer-mammal"
        } -> null
      - tags_all               = {
          - "Name" = "sg-load-balancer-mammal"
        } -> null
      - vpc_id                 = "vpc-08533456a3fdf61a6" -> null
    }

  # aws_security_group.sg-ubuntu will be destroyed
  - resource "aws_security_group" "sg-ubuntu" {
      - arn                    = "arn:aws:ec2:eu-north-1:267023797923:security-group/sg-0522595f2951594e9" -> null
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
              - security_groups  = [
                  - "sg-0bb74eeee245e89c4",
                ]
              - self             = false
              - to_port          = 0
            },
        ] -> null
      - id                     = "sg-0522595f2951594e9" -> null
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
              - cidr_blocks      = []
              - description      = "Enter WEB"
              - from_port        = 80
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = [
                  - "sg-0bb74eeee245e89c4",
                ]
              - self             = false
              - to_port          = 80
            },
        ] -> null
      - name                   = "server-ubuntu" -> null
      - owner_id               = "267023797923" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {
          - "Name" = "sg-server-mammal"
        } -> null
      - tags_all               = {
          - "Name" = "sg-server-mammal"
        } -> null
      - vpc_id                 = "vpc-08533456a3fdf61a6" -> null
    }

  # aws_subnet.subnet_pub_a will be destroyed
  - resource "aws_subnet" "subnet_pub_a" {
      - arn                                            = "arn:aws:ec2:eu-north-1:267023797923:subnet/subnet-03ff0eaa232547f1b" -> null
      - assign_ipv6_address_on_creation                = false -> null
      - availability_zone                              = "eu-north-1a" -> null
      - availability_zone_id                           = "eun1-az1" -> null
      - cidr_block                                     = "10.0.1.0/24" -> null
      - enable_dns64                                   = false -> null
      - enable_resource_name_dns_a_record_on_launch    = false -> null
      - enable_resource_name_dns_aaaa_record_on_launch = false -> null
      - id                                             = "subnet-03ff0eaa232547f1b" -> null
      - ipv6_native                                    = false -> null
      - map_customer_owned_ip_on_launch                = false -> null
      - map_public_ip_on_launch                        = false -> null
      - owner_id                                       = "267023797923" -> null
      - private_dns_hostname_type_on_launch            = "ip-name" -> null
      - tags                                           = {
          - "Name" = "subnet-mammal"
        } -> null
      - tags_all                                       = {
          - "Name" = "subnet-mammal"
        } -> null
      - vpc_id                                         = "vpc-08533456a3fdf61a6" -> null
    }

  # aws_subnet.subnet_pub_b will be destroyed
  - resource "aws_subnet" "subnet_pub_b" {
      - arn                                            = "arn:aws:ec2:eu-north-1:267023797923:subnet/subnet-02d6b865b7df047a2" -> null
      - assign_ipv6_address_on_creation                = false -> null
      - availability_zone                              = "eu-north-1b" -> null
      - availability_zone_id                           = "eun1-az2" -> null
      - cidr_block                                     = "10.0.2.0/24" -> null
      - enable_dns64                                   = false -> null
      - enable_resource_name_dns_a_record_on_launch    = false -> null
      - enable_resource_name_dns_aaaa_record_on_launch = false -> null
      - id                                             = "subnet-02d6b865b7df047a2" -> null
      - ipv6_native                                    = false -> null
      - map_customer_owned_ip_on_launch                = false -> null
      - map_public_ip_on_launch                        = false -> null
      - owner_id                                       = "267023797923" -> null
      - private_dns_hostname_type_on_launch            = "ip-name" -> null
      - tags                                           = {
          - "Name" = "subnet-mammal"
        } -> null
      - tags_all                                       = {
          - "Name" = "subnet-mammal"
        } -> null
      - vpc_id                                         = "vpc-08533456a3fdf61a6" -> null
    }

  # aws_vpc.vpc will be destroyed
  - resource "aws_vpc" "vpc" {
      - arn                              = "arn:aws:ec2:eu-north-1:267023797923:vpc/vpc-08533456a3fdf61a6" -> null
      - assign_generated_ipv6_cidr_block = false -> null
      - cidr_block                       = "10.0.0.0/16" -> null
      - default_network_acl_id           = "acl-0cd0216050257d45d" -> null
      - default_route_table_id           = "rtb-0da312c7ca0a904b6" -> null
      - default_security_group_id        = "sg-0afb4f471e88481dc" -> null
      - dhcp_options_id                  = "dopt-c560cdac" -> null
      - enable_classiclink               = false -> null
      - enable_classiclink_dns_support   = false -> null
      - enable_dns_hostnames             = true -> null
      - enable_dns_support               = true -> null
      - id                               = "vpc-08533456a3fdf61a6" -> null
      - instance_tenancy                 = "default" -> null
      - ipv6_netmask_length              = 0 -> null
      - main_route_table_id              = "rtb-0da312c7ca0a904b6" -> null
      - owner_id                         = "267023797923" -> null
      - tags                             = {
          - "Name" = "vpc-mammal"
        } -> null
      - tags_all                         = {
          - "Name" = "vpc-mammal"
        } -> null
    }

  # local_file.ssh-key-file will be destroyed
  - resource "local_file" "ssh-key-file" {
      - content              = (sensitive) -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0600" -> null
      - filename             = "./artifacts/id_rsa.priv" -> null
      - id                   = "e71e1c8795ffd24cc99d09c5ac909b64a87af2c2" -> null
    }

  # random_pet.suffix_name will be destroyed
  - resource "random_pet" "suffix_name" {
      - id        = "mammal" -> null
      - length    = 1 -> null
      - separator = "-" -> null
    }

  # tls_private_key.keys will be destroyed
  - resource "tls_private_key" "keys" {
      - algorithm                  = "RSA" -> null
      - ecdsa_curve                = "P224" -> null
      - id                         = "41e138279f526fdc9c490ee1a9f8a087029c9b1c" -> null
      - private_key_pem            = (sensitive value)
      - public_key_fingerprint_md5 = "45:c5:cb:1f:7a:47:f9:63:6a:84:e2:e6:f4:06:6d:ae" -> null
      - public_key_openssh         = <<-EOT
            ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDe5L71SxBYntRT7xYrMhK4nGCyBLGJPNINDq4TsusLjI3bqPP0o8XehYKJQkf+0a/qe+ft+QE7iwBSFSV+ID2QUevGMehA5plTHIkjNs6f07UA2+dNkSEbH5a/X2cf5VJ3HMqjxQhKIiGgukjjTn1Mo7di58wfzyq3qjXo/X+KIxMJanp+/YosUJSC5BL7Lz78ZUrIg98X8I/OW5L+4AFg83E+svVKeMTwG8hWZ+yOtGu2yTwKBJia2QmunPtIavYzgy8LPQQbpGNSitrJ3s8dc0QRItambuyU4d3iAiiXhk2E58S6CItx90Foc8QV2ZRWPXNpJ2P49BseInpSjM9H
        EOT -> null
      - public_key_pem             = <<-EOT
            -----BEGIN PUBLIC KEY-----
            MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3uS+9UsQWJ7UU+8WKzIS
            uJxgsgSxiTzSDQ6uE7LrC4yN26jz9KPF3oWCiUJH/tGv6nvn7fkBO4sAUhUlfiA9
            kFHrxjHoQOaZUxyJIzbOn9O1ANvnTZEhGx+Wv19nH+VSdxzKo8UISiIhoLpI4059
            TKO3YufMH88qt6o16P1/iiMTCWp6fv2KLFCUguQS+y8+/GVKyIPfF/CPzluS/uAB
            YPNxPrL1SnjE8BvIVmfsjrRrtsk8CgSYmtkJrpz7SGr2M4MvCz0EG6RjUorayd7P
            HXNEESLWpm7slOHd4gIol4ZNhOfEugiLcfdBaHPEFdmUVj1zaSdj+PQbHiJ6UozP
            RwIDAQAB
            -----END PUBLIC KEY-----
        EOT -> null
      - rsa_bits                   = 2048 -> null
    }

Plan: 0 to add, 0 to change, 19 to destroy.

Changes to Outputs:
  - access_LB_HTTP = "http://load-balancer-216394804.eu-north-1.elb.amazonaws.com" -> null
  - access_SSH     = [
      - "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@13.51.108.241",
      - "ssh -i ./artifacts/id_rsa.priv -o 'StrictHostKeyChecking no' ubuntu@16.170.234.111",
    ] -> null
local_file.ssh-key-file: Destroying... [id=e71e1c8795ffd24cc99d09c5ac909b64a87af2c2]
local_file.ssh-key-file: Destruction complete after 0s
aws_autoscaling_attachment.asg-ubuntu: Destroying... [id=terraform-20220317121532658400000002-20220317121559913000000003]
aws_route_table_association.a: Destroying... [id=rtbassoc-0cd841f2e3ebb1c48]
aws_route_table_association.b: Destroying... [id=rtbassoc-0c46ed595b22cac0c]
aws_lb_listener.listen-HTTP: Destroying... [id=arn:aws:elasticloadbalancing:eu-north-1:267023797923:listener/app/load-balancer/c2536886bff5d339/06ae54b9c44aa1b4]
aws_lb_listener.listen-HTTP: Destruction complete after 0s
aws_route_table_association.a: Destruction complete after 0s
aws_lb.load-balancer: Destroying... [id=arn:aws:elasticloadbalancing:eu-north-1:267023797923:loadbalancer/app/load-balancer/c2536886bff5d339]
aws_autoscaling_attachment.asg-ubuntu: Destruction complete after 0s
aws_lb_target_group.target-group-asg-ubuntu: Destroying... [id=arn:aws:elasticloadbalancing:eu-north-1:267023797923:targetgroup/target-asg-ubuntu/552bcb6e96576c60]
aws_autoscaling_group.ubuntu: Destroying... [id=terraform-20220317121532658400000002]
aws_route_table_association.b: Destruction complete after 1s
aws_route_table.route_table: Destroying... [id=rtb-033c38610cffe7878]
aws_lb_target_group.target-group-asg-ubuntu: Destruction complete after 1s
aws_route_table.route_table: Destruction complete after 0s
aws_internet_gateway.gw: Destroying... [id=igw-050bad77d10e610d1]
aws_lb.load-balancer: Destruction complete after 2s
aws_subnet.subnet_pub_b: Destroying... [id=subnet-02d6b865b7df047a2]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220317121532658400000002, 10s elapsed]
aws_internet_gateway.gw: Still destroying... [id=igw-050bad77d10e610d1, 10s elapsed]
aws_subnet.subnet_pub_b: Still destroying... [id=subnet-02d6b865b7df047a2, 10s elapsed]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220317121532658400000002, 20s elapsed]
aws_internet_gateway.gw: Still destroying... [id=igw-050bad77d10e610d1, 20s elapsed]
aws_subnet.subnet_pub_b: Still destroying... [id=subnet-02d6b865b7df047a2, 20s elapsed]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220317121532658400000002, 30s elapsed]
aws_internet_gateway.gw: Still destroying... [id=igw-050bad77d10e610d1, 30s elapsed]
aws_subnet.subnet_pub_b: Still destroying... [id=subnet-02d6b865b7df047a2, 30s elapsed]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220317121532658400000002, 40s elapsed]
aws_internet_gateway.gw: Still destroying... [id=igw-050bad77d10e610d1, 40s elapsed]
aws_subnet.subnet_pub_b: Still destroying... [id=subnet-02d6b865b7df047a2, 40s elapsed]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220317121532658400000002, 50s elapsed]
aws_internet_gateway.gw: Still destroying... [id=igw-050bad77d10e610d1, 50s elapsed]
aws_subnet.subnet_pub_b: Still destroying... [id=subnet-02d6b865b7df047a2, 50s elapsed]
aws_internet_gateway.gw: Destruction complete after 58s
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220317121532658400000002, 1m0s elapsed]
aws_subnet.subnet_pub_b: Still destroying... [id=subnet-02d6b865b7df047a2, 1m0s elapsed]
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220317121532658400000002, 1m10s elapsed]
aws_subnet.subnet_pub_b: Destruction complete after 1m9s
aws_autoscaling_group.ubuntu: Still destroying... [id=terraform-20220317121532658400000002, 1m20s elapsed]
aws_autoscaling_group.ubuntu: Destruction complete after 1m27s
aws_subnet.subnet_pub_a: Destroying... [id=subnet-03ff0eaa232547f1b]
aws_launch_configuration.ubuntu: Destroying... [id=mammal_launch_20220317121532091600000001]
aws_launch_configuration.ubuntu: Destruction complete after 0s
aws_key_pair.ssh-key: Destroying... [id=ssh-key-mammal]
aws_security_group.sg-ubuntu: Destroying... [id=sg-0522595f2951594e9]
aws_subnet.subnet_pub_a: Destruction complete after 0s
aws_key_pair.ssh-key: Destruction complete after 0s
tls_private_key.keys: Destroying... [id=41e138279f526fdc9c490ee1a9f8a087029c9b1c]
tls_private_key.keys: Destruction complete after 0s
aws_security_group.sg-ubuntu: Destruction complete after 1s
aws_security_group.sg-load-balancer: Destroying... [id=sg-0bb74eeee245e89c4]
aws_security_group.sg-load-balancer: Destruction complete after 0s
aws_vpc.vpc: Destroying... [id=vpc-08533456a3fdf61a6]
aws_vpc.vpc: Destruction complete after 1s
random_pet.suffix_name: Destroying... [id=mammal]
random_pet.suffix_name: Destruction complete after 0s

Destroy complete! Resources: 19 destroyed.
```
