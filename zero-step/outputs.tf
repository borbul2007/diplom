output "sa" {
  value = yandex_iam_service_account.sa.id
}
output "access_key" {
  value = data.yandex_lockbox_secret_version.tfstate-bucket_version.entries[1].text_value
}
output "secret_key" {
  value = data.yandex_lockbox_secret_version.tfstate-bucket_version.entries[0].text_value
}