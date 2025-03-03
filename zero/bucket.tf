resource "yandex_storage_bucket" "tfstate" {
  bucket = "tfstate-2025"
  anonymous_access_flags {
    read        = true
    list        = false
    config_read = false
  }
}
