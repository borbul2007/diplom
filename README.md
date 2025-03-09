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

# Jump host
curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
sudo apt update && sudo apt install -y unzip python3-pip git jq
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin
curl -LO "https://hashicorp-releases.yandexcloud.net/terraform/1.11.1/terraform_1.11.1_linux_amd64.zip"
sudo sudo unzip terraform_1.11.1_linux_amd64.zip -d /usr/local/bin && rm terraform_1.11.1_linux_amd64.zip
mkdir ~/keys
git clone 

git clone git clone git@github.com:kubernetes-sigs/kubespray.git && cd ~/kubespray && cp -rfp inventory/sample inventory/k8s
reboot

#ansible-playbook -i inventory.ini --private-key ~/keys/id_ed25519 cluster.yml
