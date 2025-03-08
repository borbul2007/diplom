#!/bin/bash

export ACCESS_KEY=$(echo "\"access_key=$(terraform output tfstate-bucket_access_key)" | sed -e "s/_key=\"/_key=/g")
export SECRET_KEY=$(echo "\"secret_key=$(terraform output tfstate-bucket_secret_key)" | sed -e "s/_key=\"/_key=/g")
yc iam key create --service-account-name infra --output key.json && mv key.json ~/dplm
