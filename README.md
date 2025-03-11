# Terraform Manifest
----
yc init (see URL!)
yc iam key create --service-account-name nt-terraform --output key.json && mv ~keys/nt-terraform.json

cd ~/diplom/zero-step
terraform init
terraform apply -auto-approve
chmod +x do_jump-host.sh && ./do_jump-host.sh

cd ~/diplom/infra
terraform init -backend-config=${ACCESS_KEY} -backend-config=${SECRET_KEY}
terraform apply -auto-approve
./do-inventery.sh && mv inventory.ini ~/kubespray





# Steps on the Jump host
# restore sa on local VM (https://yandex.cloud/ru/docs/cli/quickstart)
yc init (see URL!)
yc iam key create --service-account-name nt-terraform --output key.json && mv ~keys/nt-terraform.json

sudo pip3 install -r kubespray/requirements.txt
cd ~/kubespray
ansible-playbook -i inventory.ini --private-key ~/keys/id_ed25519 cluster.yml
