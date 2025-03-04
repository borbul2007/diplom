# VPC networks
resource "yandex_vpc_network" "network" {
  name = "network"
}

# VPC subnets
/*
resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet-1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet-2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}
resource "yandex_vpc_subnet" "subnet-3" {
  name           = "subnet-3"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.30.0/24"]
}
*/

resource "yandex_vpc_subnet" "subnet" {
  count          = 3
  name           = "subnet-${count.index}"
  zone           = var.k8s_networks.zones[count.index]
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.k8s_networks.cidrs[count.index]]
}
