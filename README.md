# Terraform Manifest
----
## On localhost (https://yandex.cloud/ru/docs/cli/quickstart)
yc init (see URL!)
yc iam key create --service-account-name nt-terraform --output key.json && mv ~keys/nt-terraform.json

git clone https://github.com/borbul2007/diplom.git
cd ~/diplom/zero-step
terraform init && terraform apply -auto-approve
chmod +x do_jump-host.sh && ./do_jump-host.sh

## On jump host
cd ~/diplom/infra
#cp .terraformrc ~
terraform init -backend-config=${ACCESS_KEY} -backend-config=${SECRET_KEY} && terraform apply -auto-approve
chmod +x do_k8s-cluster.sh && ./do_k8s-cluster.sh
