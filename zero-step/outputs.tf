output "tfstate-bucket_access_key" {
  value = data.yandex_lockbox_secret_version.tfstate-bucket_version.entries[1].text_value
}
output "tfstate-bucket_secret_key" {
  value = data.yandex_lockbox_secret_version.tfstate-bucket_version.entries[0].text_value
}
output "jump-host_public_ip" {
  value = yandex_compute_instance.jump-host.instance.*.network_interface.0.nat_ip_address
}