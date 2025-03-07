# Terraform Manifest
----

Создайте сервисный аккаунт, который будет в дальнейшем использоваться Terraform для работы с инфраструктурой с необходимыми и достаточными правами. Не стоит использовать права суперпользователя

Подготовьте backend для Terraform Рекомендуемый вариант: S3 bucket в созданном ЯО аккаунте(создание бакета через TF)

cd /opt/dplm_tf-mf/zero-step
terraform init
terraform apply -auto-approve
./do-tsstate-buket-key.sh && mv key.json ~/dplm

cd /opt/dplm_tf-mf/infra
terraform init -backend-config="access_key=${ACCESS_KEY}" -backend-config="secret_key=${SECRET_KEY}"
terraform apply -auto-approve
./do-kubespray-inventery.sh && mv inventory.ini ~/kubespray

cd ~/kubespray
ansible-playbook -i /inventory.ini --private-key ~/dplm/id_ed25519