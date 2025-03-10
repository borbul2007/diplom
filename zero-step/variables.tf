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

variable "k8s_networks" {
  type = list(object({
    zone = string
    cidr = string
  }))  
  default = [
    {
      zone = "ru-central1-a"
      cidr = "192.168.10.0/24"
    },
    {
      zone = "ru-central1-b"
      cidr = "192.168.20.0/24"
    },
    {
      zone = "ru-central1-d"
      cidr = "192.168.30.0/24"
    }
  ]
  description = "Networks for K8S cluster"
}

variable "cloud-init_file" {
  type        = string
  default     = "./resources/metadata.yaml"
  description = "Cloud-init config"
}