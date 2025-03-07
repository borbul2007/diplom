resource "yandex_iam_service_account" "k8s" {
  name        = "k8s"
  description = "Service account for managing K8S instance group"
}
resource "yandex_resourcemanager_folder_iam_member" "k8s-editor" {
  folder_id  = var.folder_id
  role       = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.k8s.id}"
  depends_on = [yandex_iam_service_account.k8s]
}