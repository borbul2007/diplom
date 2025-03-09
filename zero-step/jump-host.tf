resource "yandex_compute_instance" "jump-host" {
  name        = "jump-host"
  platform_id = "standard-v1"
  zone        = var.default_zone
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = "fd8kc2n656prni2cimp5"
      size     = 10
      type     = "network-hdd"
    }
  }
  network_interface {
    network_id = "${yandex_vpc_network.k8s.id}"
    subnet_ids = [yandex_vpc_subnet.k8s-1.id]
#    nat        = true
  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    serial-port-enable = 1
    user-data          = "${local.cloud-init}"
  }
}