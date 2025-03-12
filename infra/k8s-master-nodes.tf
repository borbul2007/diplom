resource "yandex_compute_instance_group" "k8s-master-nodes" {
  name                = "k8s-master-nodes"
  folder_id           = var.folder_id
  service_account_id  = "${yandex_iam_service_account.k8s.id}"
  depends_on          = [yandex_resourcemanager_folder_iam_member.k8s-editor]
  instance_template {
    name = "k8s-master-node-{instance.index}"
    platform_id = "standard-v2"
    resources {
      cores         = var.instance_resources_cores
      memory        = var.instance_resources_memory
      core_fraction = var.instance_resources_core_fraction
    }
    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.vm-image.image_id
        size     = 10
        type     = "network-hdd"
      }
    }
    network_interface {
      network_id = "${var.yandex_vpc_network_k8s_id}"
      subnet_ids = [var.yandex_vpc_subnet_k8s_0_id,var.yandex_vpc_subnet_k8s_1_id,var.yandex_vpc_subnet_k8s_2_id]
      nat        = true
    }
    scheduling_policy {preemptible = true}
    metadata = {
      serial-port-enable = 1
      user-data          = "${local.cloud-init}"
    }
  }
  scale_policy {
    fixed_scale {
      size = 3
    }
  }
  allocation_policy {
    zones = ["ru-central1-a","ru-central1-b","ru-central1-d"]
  }
  deploy_policy {
    max_unavailable = 3
    max_expansion   = 3
    max_creating    = 3
    max_deleting    = 3
  }
  health_check {
   tcp_options {
      port = 22
    }
  }
}