output "k8s_master_nodes_private_ips" {
  value = yandex_compute_instance_group.k8s-master-nodes.instances.*.network_interface.0.ip_address
}
output "k8s_worker_nodes_private_ips" {
  value = yandex_compute_instance_group.k8s-worker-nodes.instances.*.network_interface.0.ip_address
}
output "network_load_balancer_public_ip" {
  value = yandex_lb_network_load_balancer.k8s.listener.*.external_address_spec[0].*.address
}
output "k8s_api_node_private_ip" {
  value = yandex_compute_instance_group.k8s-master-nodes.instances.1.network_interface.0.ip_address
}