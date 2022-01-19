#!/bin/bash
yum -y update
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user
systemctl enable docker
docker push bezhav/cv_turquoise:v1
docker run -d -p80:80 bezhav/cv_turquoise:v1
