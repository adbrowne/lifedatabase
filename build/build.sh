#!/bin/bash
echo Entered the build phase...
echo Build started on `date`
nvm use lts
terraform init
terraform apply -auto-approve