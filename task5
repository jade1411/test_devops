terraform {
  required_version = ">= 0.13"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  zone = "ru-central1-b"
}

resource "yandex_compute_disk" "example_disk" {
  name = "example-disk"
  size = 10
  zone = "ru-central1-b"
}

resource "yandex_vpc_network" "example_network" {
  name = "example-network"
}

resource "yandex_vpc_subnet" "example_subnet" {
  name          = "example-subnet"
  v4_cidr_blocks = ["10.0.0.0/24"]
  network_id    = yandex_vpc_network.example_network.id
}

resource "yandex_compute_instance" "example_instance" {
  name        = "example-instance"
  zone        = "ru-central1-b"
  platform_id = "standard-v1"

  resources {
    memory = 2
    cores  = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8e5mhltqne1quu1bik"
    }
  }

  network_interface {
    nat = true 
    subnet_id = yandex_vpc_subnet.example_subnet.id
  }

  secondary_disk {
    disk_id = yandex_compute_disk.example_disk.id
    mode    = "READ_WRITE"
  }
}
