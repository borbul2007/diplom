resource "yandex_iam_service_account" "sa" {
  name        = "infra-editor"
  description = "Service account for managing infrastructure"
}
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id  = var.folder_id
  role       = "editor"
  member     = "serviceAccount:${yandex_iam_service_account.sa.id}"
}
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "Static access key for object storage"
}