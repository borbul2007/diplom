terraform {
  required_providers {
    yandex = {source = "yandex-cloud/yandex"}
  }
  required_version = "~>1.8.4"
  backend "s3" {
    endpoints = {s3 = "https://storage.yandexcloud.net"}
    bucket    = "tfstate-2025"
    region    = "ru-central1"
    key       = "terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true 
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  service_account_key_file = file("~/keys/infra.json")
  zone                     = var.default_zone
}
