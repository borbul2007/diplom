resource "yandex_iam_service_account" "k8s-ig" {
  name        = "k8s-ig"
  description = "Service account for managing K8S instance group"
}
resource "yandex_resourcemanager_folder_iam_member" "k8s-ig" {
  folder_id  = var.folder_id
  role       = "editor"
  member     = "serviceAccount:${yandex_iam_service_account.k8s-ig.id}"
  depends_on = [yandex_iam_service_account.k8s-ig]
}
