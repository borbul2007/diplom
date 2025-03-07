resource "yandex_lb_network_load_balancer" "k8s" {
  name = "k8s"
  listener {
    name = "k8s"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_compute_instance_group.k8s-master-nodes.load_balancer.0.target_group_id
    healthcheck {
      name = "ssh"
      tcp_options {
        port = 22
      }
    }
  }
}