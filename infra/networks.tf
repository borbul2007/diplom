resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "subnet" {
  count          = length(var.k8s_networks)
  network_id     = yandex_vpc_network.network.id
  name           = "subnet-${count.index}"
  zone           = var.k8s_networks[count.index].zone
  v4_cidr_blocks = [var.k8s_networks[count.index].cidr]
  depends_on     = [yandex_vpc_network.network]
}