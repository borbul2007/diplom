# VPC networks
resource "yandex_vpc_network" "network" {
  name = "network"
}

# VPC subnets
/*
resource "yandex_vpc_subnet" "subnet" {
  count          = 3
  name           = "subnet-${count.index}"
  zone           = var.k8s_networks.zones[count.index]
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.k8s_networks.cidrs[count.index]]
}
*/

resource "yandex_vpc_subnet" "subnet" {
  count = length(var.k8s_networks)
  network_id     = yandex_vpc_network.network.id
  name           = "subnet-${count.index}"
  zone           = var.k8s_networks.zone[count.index]
  v4_cidr_blocks = [var.k8s_networks.cidr[count.index]]
}