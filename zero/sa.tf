resource "yandex_iam_service_account" "infra-sa" {
  name        = "infra-sa"
  description = "Service account for managing infrastructure"
}
resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id  = var.folder_id
  role       = "editor"
  member     = "serviceAccount:${yandex_iam_service_account.infra-sa.id}"
  depends_on = [yandex_iam_service_account.infra-sa]
}
