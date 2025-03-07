data "yandex_compute_image" "vm-image" {
  family = var.image_family
}

resource "yandex_compute_instance_group" "k8s-master-nodes" {
  name                = "k8s-master-nodes"
  folder_id           = var.folder_id
  service_account_id  = "${yandex_iam_service_account.k8s.id}"
  depends_on          = [yandex_vpc_network.k8s,yandex_resourcemanager_folder_iam_member.k8s-editor]
  instance_template {
    name = "k8s-node-{instance.index}"
    platform_id = var.instance_platform_id
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
      network_id = "${yandex_vpc_network.k8s.id}"
      subnet_ids = [yandex_vpc_subnet.k8s-1.id,yandex_vpc_subnet.k8s-2.id,yandex_vpc_subnet.k8s-3.id]
      nat        = true
    }
    scheduling_policy {
      preemptible = true
    }
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
    max_unavailable = 1
    max_expansion   = 0
  }
  health_check {
   tcp_options {
      port = 22
    }
  }
  load_balancer {
    target_group_name        = "k8s"
    target_group_description = "Network Load Balancer K8S target group"
  }
}