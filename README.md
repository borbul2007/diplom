# Terraform Manifest
----
## On localhost (https://yandex.cloud/ru/docs/cli/quickstart)
yc init (see URL!)
yc iam key create --service-account-name nt-terraform --output key.json && mv ~keys/nt-terraform.json

cd ~/diplom && git clone https://github.com/borbul2007/diplom.git

cd ~/diplom/zero-step
terraform init && terraform apply -auto-approve
./do_jump-host.sh

## On jump host
cd ~/diplom/infra
terraform init -backend-config=${ACCESS_KEY} -backend-config=${SECRET_KEY} && terraform apply -auto-approve
./do_k8s-cluster.sh


git clone -b release-2.24 https://github.com/kubernetes-sigs/kubespray.git
vi /home/ubuntu/kubespray/roles/kubernetes/preinstall/tasks/0040-verify-settings.yml
alias ll='ls -lsa --color=auto'