# Terraform Manifest
----

cd /opt/dplm_tf-mf/zero-step
terraform init
terraform apply -auto-approve
./do-key.sh && mv key.json ~/dplm

cd /opt/dplm_tf-mf/infra
terraform init -backend-config="access_key=${ACCESS_KEY}" -backend-config="secret_key=${SECRET_KEY}"
terraform apply -auto-approve
./do-inventery.sh && mv inventory.ini ~/kubespray

cd ~/kubespray
ansible-playbook -i inventory.ini --private-key ~/dplm/id_ed25519 cluster.yml


# restore sa on local VM (https://yandex.cloud/ru/docs/cli/quickstart)
# yc init (see URL!)
# yc iam key create --service-account-name nt-terraform --output key.json && mv ~key.json