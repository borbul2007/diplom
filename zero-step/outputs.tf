output "tfstate-bucket_access_key" {
  value = data.yandex_lockbox_secret_version.tfstate-bucket_version.entries[1].text_value
}
output "tfstate-bucket_secret_key" {
  value = data.yandex_lockbox_secret_version.tfstate-bucket_version.entries[0].text_value
}
output "jump-host_public_ip" {
  value = yandex_compute_instance.jump-host.network_interface.0.nat_ip_address
}
output "yandex_vpc_network_k8s_id" {
  value = yandex_vpc_network.k8s.id
}
output "yandex_vpc_subnet_k8s-0_id" {
  value = yandex_vpc_subnet.k8s-0.id
}