# VPC networks
resource "yandex_vpc_network" "network" {
  name = "network"
}

# VPC subnets
resource "yandex_vpc_subnet" "public-a" {
  name           = "subnet-1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.public_yandex_vpc_subnet_default_cidr
}
resource "yandex_vpc_subnet" "public-b" {
  name           = "subnet-2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.public_yandex_vpc_subnet_default_cidr
}
resource "yandex_vpc_subnet" "public-d" {
  name           = "subnet-3"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.public_yandex_vpc_subnet_default_cidr
}