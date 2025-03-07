output "instance_group_k8s_master_nodes_public_ips" {
  value = yandex_compute_instance_group.k8s-master-nodes.instances.*.network_interface.0.nat_ip_address
  description = "Public IP addresses for K8S master nodes"
}

output "instance_group_k8s_masters_nodes_private_ips" {
  value = yandex_compute_instance_group.k8s-master-nodes.instances.*.network_interface.0.ip_address
  description = "Private IP addresses for K8S master nodes"
}

output "instance_group_k8s_workers_nodes_public_ips" {
  value = yandex_compute_instance_group.k8s-worker-nodes.instances.*.network_interface.0.nat_ip_address
  description = "Public IP addresses for K8S worker nodes"
}

output "instance_group_k8s_workers_nodes_private_ips" {
  value = yandex_compute_instance_group.k8s-worker-nodes.instances.*.network_interface.0.ip_address
  description = "Private IP addresses for K8S worker nodes"
}

output "network_load_balancer_public_ip" {
  value = yandex_lb_network_load_balancer.k8s.listener.*.external_address_spec[0].*.address
  description = "Public IP address of K8S Network Load Balancer"
}