output "instance_group_k8s_master_nodes_public_ips" {
  description = "Public IP addresses for k8s-master-nodes"
  value = yandex_compute_instance_group.k8s-master-nodes.instances.*.network_interface.0.nat_ip_address
}

#output "instance_group_k8s_masters_private_ips" {
#  description = "Private IP addresses for master-nodes"
#  value = yandex_compute_instance_group.k8s-masters.instances.*.network_interface.0.ip_address
#}

#output "instance_group_workers_public_ips" {
#  description = "Public IP addresses for worder-nodes"
#  value = yandex_compute_instance_group.k8s-workers.instances.*.network_interface.0.nat_ip_address
#}

#output "instance_group_workers_private_ips" {
#  description = "Private IP addresses for worker-nodes"
#  value = yandex_compute_instance_group.k8s-workers.instances.*.network_interface.0.ip_address
#}

output "load_balancer_public_ip" {
  description = "Public IP address of K8S Network Load Balancer"
  value = yandex_lb_network_load_balancer.k8s.listener.*.external_address_spec[0].*.address
}