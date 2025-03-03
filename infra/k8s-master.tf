resource "yandex_kubernetes_cluster" "k8s" {
  name = "k8s"
  network_id = yandex_vpc_network.network.id
  master {
    master_location {
      zone      = yandex_vpc_subnet.subnet-1.zone
      subnet_id = yandex_vpc_subnet.subnet-1.id
    }
    master_location {
      zone      = yandex_vpc_subnet.subnet-2.zone
      subnet_id = yandex_vpc_subnet.subnet-2.id
    }
    master_location {
      zone      = yandex_vpc_subnet.subnet-3.zone
      subnet_id = yandex_vpc_subnet.subnet-3.id
    }
    security_group_ids = [yandex_vpc_security_group.k8s-sg.id]
  }
  service_account_id      = yandex_iam_service_account.my-regional-account.id
  node_service_account_id = yandex_iam_service_account.my-regional-account.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller,
    yandex_resourcemanager_folder_iam_member.encrypterDecrypter
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}

#resource "yandex_iam_service_account" "my-regional-account" {
#  name        = "regional-k8s-account"
#  description = "K8S regional service account"
#}

resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
  # Сервисному аккаунту назначается роль "k8s.clusters.agent".
  folder_id = local.folder_id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
  # Сервисному аккаунту назначается роль "vpc.publicAdmin".
  folder_id = local.folder_id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = local.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
  # Сервисному аккаунту назначается роль "kms.keys.encrypterDecrypter".
  folder_id = local.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
}

resource "yandex_kms_symmetric_key" "key-kms-key" {
  name              = "k8s-kms-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}

resource "yandex_vpc_security_group" "k8s-sg" {
  name        = "k8s-sg"
  network_id  = yandex_vpc_network.network.id
  ingress {
    protocol          = "TCP"
    description       = "LB healthcheck"
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    description       = "Traffic master-master and node-node"
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    description       = "Traffic pod-pod and service-service"
    v4_cidr_blocks    = concat(yandex_vpc_subnet.subnet-1.v4_cidr_blocks, yandex_vpc_subnet.subnet-2.v4_cidr_blocks, yandex_vpc_subnet.subnet-3.v4_cidr_blocks)
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ICMP"
    description       = "ICMP from local subnet"
    v4_cidr_blocks    = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  }
  ingress {
    protocol          = "TCP"
    description       = "Internet traffic to NodePort port range"
    v4_cidr_blocks    = ["0.0.0.0/0"]
    from_port         = 30000
    to_port           = 32767
  }
  egress {
    protocol          = "ANY"
    description       = "Outbound traffic (Yandex Container Registry, Yandex Object Storage, Docker Hub)"
    v4_cidr_blocks    = ["0.0.0.0/0"]
    from_port         = 0
    to_port           = 65535
  }
}