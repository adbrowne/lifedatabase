#!/usr/bin/env bash

aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 662430452979.dkr.ecr.us-west-2.amazonaws.com

aws ecr create-repository \
    --repository-name lifedatabase-web \
    --image-scanning-configuration scanOnPush=true \
    --region us-west-2

docker tag lifedatabase-web:latest 662430452979.dkr.ecr.us-west-2.amazonaws.com/lifedatabase-web:latest

docker push 662430452979.dkr.ecr.us-west-2.amazonaws.com/lifedatabase-web:latest

ecs-cli compose --project-name lifedatabase service up --create-log-groups --cluster-config lifedatabase --target-groups "targetGroupArn=arn:aws:elasticloadbalancing:us-west-2:662430452979:targetgroup/lifedatabase-web3/fd5c54b25ac7de08,containerName=web,containerPort=80"
