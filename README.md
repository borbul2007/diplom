# Terraform Manifest
----

cd /opt/dplm_tf-mf/zero-step
terraform init
terraform apply -auto-approve
./do-key.sh

cd /opt/dplm_tf-mf/infra
#terraform init ${BACKEND_CONFIG}
terraform init -backend-config=${ACCESS_KEY} -backend-config=${SECRET_KEY}
terraform apply -auto-approve
./do-inventery.sh && mv inventory.ini ~/kubespray

cd ~/kubespray
ansible-playbook -i inventory.ini --private-key ~/dplm/id_ed25519 cluster.yml


# restore sa on local VM (https://yandex.cloud/ru/docs/cli/quickstart)
# yc init (see URL!)
# yc iam key create --service-account-name nt-terraform --output key.json && mv ~key.json

Jump host
sudo apt install python3-pip git helm jq

curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash

sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
sudo apt update
sudo apt-get install terraform