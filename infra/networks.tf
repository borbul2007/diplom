resource "yandex_vpc_network" "k8s" {
  name = "k8s"
}

resource "yandex_vpc_subnet" "subnet" {
  count          = length(var.k8s_networks)
  network_id     = yandex_vpc_network.network.id
  name           = "subnet-${count.index}"
  zone           = var.k8s_networks[count.index].zone
  v4_cidr_blocks = [var.k8s_networks[count.index].cidr]
  depends_on     = [yandex_vpc_network.network]
}

/*
resource "yandex_vpc_subnet" "k8s-1" {
  name           = "k8s-1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.k8s.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "k8s-2" {
  name           = "k8s-2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.k8s.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}

resource "yandex_vpc_subnet" "k8s-3" {
  name           = "k8s-3"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.k8s.id
  v4_cidr_blocks = ["192.168.30.0/24"]
}
*/