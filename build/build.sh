#!/usr/bin/env bash

set -Eeuo pipefail

echo Entered the build phase...
echo Build started on `date`
#nvm use lts
cd api
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 662430452979.dkr.ecr.us-west-2.amazonaws.com

REPO_NAME=lifedatabase-api
aws ecr describe-repositories --repository-names ${REPO_NAME} --region us-west-2 || aws ecr create-repository --repository-name ${REPO_NAME} --region us-west-2

docker build . -t 662430452979.dkr.ecr.us-west-2.amazonaws.com/lifedatabase-api
docker push 662430452979.dkr.ecr.us-west-2.amazonaws.com/lifedatabase-api:latest

cd ..

terraform init
terraform apply -auto-approve