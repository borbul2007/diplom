#!/bin/bash

echo "export ACCESS_KEY=$(echo "\"access_key=$(terraform output tfstate-bucket_access_key)" | sed -e "s/_key=\"/_key=/g")" >> resources/.profile
echo "export SECRET_KEY=$(echo "\"secret_key=$(terraform output tfstate-bucket_secret_key)" | sed -e "s/_key=\"/_key=/g")" >> resources/.profile
echo "export PUBLIC_IP=$(terraform output jump-host_public_ip)" >> resources/.profile
yc iam key create --service-account-name infra --output resources/infra.json


