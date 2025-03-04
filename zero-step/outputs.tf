output "tfstate-bucket_access-key" {
  value = data.yanyandex_iam_service_account_static_access_key.tfstate-bucket-keys.entries[1].text_value
}
output "tfstate-bucket_secret-key" {
  value = data.yanyandex_iam_service_account_static_access_key.tfstate-bucket-keys.entries[0].text_value
}

output "access_key" {
  value = data.yandex_lockbox_secret_version.tfstate-bucket_version.entries[1].text_value
}
output "secret_key" {
  value = data.yandex_lockbox_secret_version.tfstate-bucket_version.entries[0].text_value
}