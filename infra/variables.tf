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

data "yandex_compute_image" "vm-image" {
  family     = var.image_family
}

variable "image_family" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "VM image family"
}

variable "instance_resources_cores" {
  type        = number
  default     = 2
  description = "VM number of CPU"
}

variable "instance_resources_memory" {
  type        = number
  default     = 2
  description = "VM number of memory"
}

variable "instance_resources_core_fraction" {
  type        = number
  default     = 5
  description = "VM number of core fraction"
}

variable "cloud-init_file" {
  type        = string
  default     = "./metadata.yaml"
  description = "Cloud-init config"
}

variable "yandex_vpc_network_k8s" {
  type = string
}
variable "ndex_vpc_subnet_k8s_0_id" {
  type = string
}
variable "ndex_vpc_subnet_k8s_1_id" {
  type = string
}
