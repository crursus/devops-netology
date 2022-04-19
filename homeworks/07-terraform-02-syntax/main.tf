// Configure the Yandex.Cloud provider
provider "yandex" {
  token                    = "$YC_TOKEN"
//  service_account_key_file = "key.json"
  cloud_id                 = "b1g3ii1qu7gekn8tbs9i"
  folder_id                = "b1gsnd3rguol7eah762s"
  zone                     = "ru-central1-a"
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

resource "yandex_vpc_network" "net" {
  name = "net"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet"
  network_id     = resource.yandex_vpc_network.net.id
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
}

resource "yandex_compute_instance" "vm" {
  name        = "kaa-vm-01"
  hostname    = "kaa_vm-01.local"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = "network-hdd"
      size     = "20"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
    ipv6      = false
  }
}
