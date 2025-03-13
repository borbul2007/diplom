#!/bin/bash

cd ~/diplom/zero-step
echo "export JUMP_HOST_PUBLIC_IP=$(terraform output jump-host_public_ip | xargs)" >> ~/.profile && source ~/.profile
echo "export ACCESS_KEY=$(echo "\"access_key=$(terraform output tfstate-bucket_access_key)" | sed -e "s/_key=\"/_key=/g")" >> ./resources/.profile
echo "export SECRET_KEY=$(echo "\"secret_key=$(terraform output tfstate-bucket_secret_key)" | sed -e "s/_key=\"/_key=/g")" >> ./resources/.profile
echo "export TF_VAR_yandex_vpc_network_k8s_id=$(terraform output yandex_vpc_network_k8s_id)" >> ./resources/.profile
echo "export TF_VAR_yandex_vpc_subnet_k8s_0_id=$(terraform output yandex_vpc_subnet_k8s-0_id)" >> ./resources/.profile
echo "export TF_VAR_yandex_vpc_subnet_k8s_1_id=$(terraform output yandex_vpc_subnet_k8s-1_id)" >> ./resources/.profile
echo "export TF_VAR_yandex_vpc_subnet_k8s_2_id=$(terraform output yandex_vpc_subnet_k8s-2_id)" >> ./resources/.profile

yc iam key create --service-account-name infra --output ./resources/infra.json

scp -i ~/keys/id_ed25519 ~/keys/* ubuntu@${JUMP_HOST_PUBLIC_IP}:/home/ubuntu/keys/
scp -i ~/keys/id_ed25519 ./resources/infra.json ubuntu@${JUMP_HOST_PUBLIC_IP}:/home/ubuntu/keys/
scp -i ~/keys/id_ed25519 ./resources/.profile ubuntu@${JUMP_HOST_PUBLIC_IP}:/home/ubuntu/
#ssh -i ~/keys/id_ed25519 ubuntu@${JUMP_HOST_PUBLIC_IP}
