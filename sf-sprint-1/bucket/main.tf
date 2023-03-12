terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.85.0"
    }
  }
  #backend "s3" {
  #  endpoint   = "storage.yandexcloud.net"
  #  bucket     = "sfd-state-bucket"
  #  region     = "ru-central1-a"
  #  key        = "issue1/lemp.tfstate"
  #  access_key = "YCAJESHSHe2UghJtWpL6w_1sy"
  #  secret_key = "YCNKS6YJJMphdn7shdp-sRZZaUuPJhCusNa3306e"
#
  #  skip_region_validation      = true
  #  skip_credentials_validation = true
  #}
}

provider "yandex" {
  token     = "y0_AgAAAAABga1xAATuwQAAAADORS9MjNZ6-eaDR7-pf8CQWjfEsBkux3g"
  cloud_id  = "b1g083uvuks4c1o8jf5l"
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

 # Создаем сервис-аккаунт SA
 resource "yandex_iam_service_account" "sa" {
   folder_id = var.folder_id
   name      = "sfd"
 }
 
 # Даем права на запись для этого SA
 resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
   folder_id = var.folder_id
   role      = "storage.editor"
   member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
 }
 
 # Создаем ключи доступа Static Access Keys
 resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
   service_account_id = yandex_iam_service_account.sa.id
   description        = "static access key for object storage"
 }
 
 # Создаем хранилище
 resource "yandex_storage_bucket" "state" {
   bucket     = "sfd-state-bucket"
   access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
   secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
 }

# data "yandex_compute_image" "my_image" {
#   family = "lemp"
# }
# 
# resource "yandex_compute_instance" "vm-1" {
#   name = "terraform1"
# 
#   resources {
#     cores  = 2
#     memory = 2
#   }
# 
#   boot_disk {
#     initialize_params {
#       image_id = data.yandex_compute_image.my_image.id
#     }
#   }
# 
#   network_interface {
#     subnet_id = yandex_vpc_subnet.subnet-1.id
#     nat       = true
#   }
# 
#   metadata = {
#     ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
#   }
# }
# 
# resource "yandex_vpc_network" "network-1" {
#   name = "network1"
# }
# 
# resource "yandex_vpc_subnet" "subnet-1" {
#   name           = "subnet1"
#   zone           = "ru-central1-a"
#   network_id     = yandex_vpc_network.network-1.id
#   v4_cidr_blocks = ["192.168.10.0/24"]
# }