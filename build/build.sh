#!/bin/bash
echo Entered the build phase...
echo Build started on `date`
nvm use lts
cd api
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 662430452979.dkr.ecr.us-west-2.amazonaws.com
docker build . -t 662430452979.dkr.ecr.us-west2.amazonaws.com/lifedatabase-api
docker push 662430452979.dkr.ecr.us-west2.amazonaws.com/lifedatabase-api:latest

cd ..

terraform init
terraform apply -auto-approve