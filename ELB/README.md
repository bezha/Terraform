# Highly Available CV with AWS Application ELB on 3 docker containers in 3 availablity zones provision with Terraform

This folder contains an example [Terraform](https://www.terraform.io/) configuration that deploys a cluster of web servers 
(using [EC2](https://aws.amazon.com/ec2/) with prepaired user_data that have 3 different colors CV in docker containers and a load balancer (using [ELB](https://aws.amazon.com/elasticloadbalancing/)) in an [Amazon Web Services (AWS) 
account](http://aws.amazon.com/). The load balancer listens on port 80 and returns the 3 different color CV for the  `/` URL.

## Pre-requisites

* You must have [Terraform](https://www.terraform.io/) installed on your computer. 
* You must have an [Amazon Web Services (AWS) account](http://aws.amazon.com/).

## Quick start

Configure your [AWS access keys](http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) as environment variables:

```
export AWS_ACCESS_KEY_ID=(your access key id)
export AWS_SECRET_ACCESS_KEY=(your secret access key)
export AWS_DEFAULT_REGION="eu-central-1"
```

Deploy the code:

```
terraform init
terraform apply
```

When the `apply` command completes, it will output the DNS name of the load balancer. To test the load balancer:

```
alb_dns_name = "CV-xxxxxxxxxxx.eu-central-1.elb.amazonaws.com"
burgundy_public_ip = "x.x.x.x"
green_public_ip = "x.x.x.x"
turquoise_public_ip = "x.x.x.x"

```

Clean up when done:

```
terraform destroy
```