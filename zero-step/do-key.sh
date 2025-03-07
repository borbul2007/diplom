#!/bin/bash

export ACCESS_KEY=$(terraform output tfstate-bucket_access_key)
export SECRET_KEY=$(terraform output tfstate-bucket_secret_key)
yc iam key create --service-account-name infra --output key.json
