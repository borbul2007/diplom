resource "yandex_storage_bucket" "tfstate" {
  bucket                = var.tfstate_bucket_name
  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }
}
