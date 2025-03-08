#!/bin/bash

#export ACCESS_KEY=$(terraform output tfstate-bucket_access_key)
#export SECRET_KEY=$(terraform output tfstate-bucket_secret_key)
export ACCESS_KEY=$(terraform output access_key)
export SECRET_KEY=$(terraform output secret_key)
yc iam key create --service-account-name infra --output key.json && mv key.json ~/dplm
