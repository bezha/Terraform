#!/bin/bash
yum -y update
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user
systemctl enable docker
