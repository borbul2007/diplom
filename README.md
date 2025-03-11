# Terraform Manifest
----

cd ~/diplom/zero-step
terraform init
terraform apply -auto-approve
./do-key.sh

cd ~/diplom/infra
terraform init -backend-config=${ACCESS_KEY} -backend-config=${SECRET_KEY}
terraform apply -auto-approve
./do-inventery.sh && mv inventory.ini ~/kubespray


# Jump host
Create JH in YC

curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
sudo apt update && sudo apt install -y unzip python3-pip git jq
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin
curl -LO "https://hashicorp-releases.yandexcloud.net/terraform/1.11.1/terraform_1.11.1_linux_amd64.zip"
sudo unzip -u terraform_1.11.1_linux_amd64.zip -d /usr/local/bin && rm terraform_1.11.1_linux_amd64.zip
curl -O https://get.helm.sh/helm-v3.17.1-linux-amd64.tar.gz
tar xvf helm-v3.17.1-linux-amd64.tar.gz && sudo mv linux-amd64/helm /usr/local/bin
rm helm-v3.17.1-linux-amd64.tar.gz && rm -rf linux-amd64
mkdir ~/keys
git clone https://github.com/borbul2007/diplom.git 
git clone https://github.com/kubernetes-sigs/kubespray.git
reboot

chmod +x do_jump-host.sh && ./do_jump-host.sh


# Steps on the Jump host
# restore sa on local VM (https://yandex.cloud/ru/docs/cli/quickstart)
yc init (see URL!)
yc iam key create --service-account-name nt-terraform --output key.json && mv ~keys/nt-terraform.json

sudo pip3 install -r kubespray/requirements.txt
cd ~/kubespray
ansible-playbook -i inventory.ini --private-key ~/keys/id_ed25519 cluster.yml
