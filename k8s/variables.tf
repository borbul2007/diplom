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

variable "public_yandex_vpc_subnet_default_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "tfstate_bucket_name" {
  type        = string
  default     = "tfstate-2025"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}