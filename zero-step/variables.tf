variable "cloud_id" {
  type        = string
  default     = "b1guau0af4j7qkg1484e"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gkg5og1lpl8fc1563m"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "tfstate_bucket_name" {
  type        = string
  default     = "tfstate-2025"
  description = "Yandex Object Storage bucket for Terraform state"
}

variable "cloud-init_file" {
  type        = string
  default     = "./resources/metadata.yaml"
  description = "Cloud-init config"
}