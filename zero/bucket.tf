resource "yandex_storage_bucket" "tfstate" {
  bucket = var.state_bucket_name
  anonymous_access_flags {
    read        = true
    list        = false
    config_read = false
  }
}
