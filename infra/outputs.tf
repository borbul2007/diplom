output "k8s_master_nodes_public_ips" {
  value = yandex_compute_instance_group.k8s-master-nodes.instances.*.network_interface.0.nat_ip_address
}
output "k8s_master_nodes_private_ips" {
  value = yandex_compute_instance_group.k8s-master-nodes.instances.*.network_interface.0.ip_address
}
output "k8s_worker_nodes_public_ips" {
  value = yandex_compute_instance_group.k8s-worker-nodes.instances.*.network_interface.0.nat_ip_address
}
output "k8s_worker_nodes_private_ips" {
  value = yandex_compute_instance_group.k8s-worker-nodes.instances.*.network_interface.0.ip_address
}
output "network_load_balancer_public_ip" {
  value = yandex_lb_network_load_balancer.k8s.listener.*.external_address_spec[0].*.address
}
