#!/bin/bash

export BACKEND_CONFIG=$(echo "-backend-config=\"access_key=$(terraform output tfstate-bucket_access_key) -backend-config=\"secret_key=$(terraform output tfstate-bucket_secret_key)" | sed -e "s/_key=\"/_key=/g")
yc iam key create --service-account-name infra --output key.json && mv key.json ~/dplm
