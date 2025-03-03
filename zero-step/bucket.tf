resource "yandex_kms_symmetric_key" "tfstate-bucket-key" {
  name              = "tfstate-bucket-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}

resource "yandex_storage_bucket" "tfstate" {
  bucket                = var.tfstate_bucket_name
  max_size              = 10485760
  grant {
    id          = yandex_iam_service_account.sa.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.tfstate-bucket-key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}
