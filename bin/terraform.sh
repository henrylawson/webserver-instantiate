#!/bin/bash
set -xeuo pipefail

DIR=$( cd $(dirname $0) ; pwd -P )
TERRAFORM_COMMAND=$1
TERRAFORM_COMMANDS=$@
WORKSPACE_DIR=$DIR/../..
TERRAFORM_CREDS=$WORKSPACE_DIR/libraye/libraye-creds/terraform/aws_credentials.tfvars.crypt

terraform remote config \
    -backend=s3 \
    -backend-config="bucket=webserver-terraform-state-production" \
    -backend-config="key=webserver-instantiate/terraform.tfstate" \
    -backend-config="region=us-east-1"

# run terraform command
if [ $TERRAFORM_COMMAND = "output" ]; then
  terraform $TERRAFORM_COMMANDS
else
  terraform $TERRAFORM_COMMANDS \
    -var-file="$TERRAFORM_CREDS"
fi
