# Terraform Manifest
----

Создайте сервисный аккаунт, который будет в дальнейшем использоваться Terraform для работы с инфраструктурой с необходимыми и достаточными правами. Не стоит использовать права суперпользователя

Подготовьте backend для Terraform Рекомендуемый вариант: S3 bucket в созданном ЯО аккаунте(создание бакета через TF)

Использовать output заполнить
export ACCESS_KEY=""
export SECRET_KEY=""
terraform init -backend-config="access_key=" -backend-config=""

yc iam service-accounts list
yc iam key create --service-account-name infra-editor --output key.json