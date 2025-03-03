resource "yandex_storage_bucket" "tfstate" {
  bucket                = var.state_bucket_name
  access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  anonymous_access_flags {
    read        = <true>
    list        = <true>
    config_read = <true>
  }
}
