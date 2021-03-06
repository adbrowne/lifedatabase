#!/bin/bash

echo Install terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update && apt-get install terraform
echo Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash 
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"
nvm install lts
npm install -g yarn