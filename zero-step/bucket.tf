resource "yandex_kms_symmetric_key" "key" {
  name              = "key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}

resource "yandex_storage_bucket" "tfstate" {
  bucket                = var.tfstate_bucket_name
#  access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#  secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  max_size              = 1048576
  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}
