# Домашнее задание к занятию "3.4. Операционные системы, лекция 2"

1. Создал простой unit-файл для node_exporter:

    * ![Proof](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-04-os-01.png)

    * поместил его в автозагрузку `sudo systemctl enable node_exporter`
    * предусмотрел возможность добавления опций к запускаемому процессу через внешний файл
    * процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается
   
      ![Proof](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-04-os-02.png)

1. Ознакомился с опциями node_exporter и выводом `/metrics` по-умолчанию:
   
   ![Proof](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-04-os-03.png)

   Несколько опций, которые можно выбрать для базового мониторинга хоста, например:
   
   * **CPU**
      * node_cpu_guest_seconds_total{cpu="0",mode="user"}
      * node_cpu_seconds_total{cpu="0",mode="idle"}
      * node_cpu_seconds_total{cpu="0",mode="system"}
      * node_cpu_seconds_total{cpu="0",mode="user"}
      * process_cpu_seconds_total
   * **Memory**
      * node_memory_MemAvailable_bytes 
      * node_memory_MemFree_bytes
    
   * **Disk**
      * node_disk_io_time_seconds_total{device="sda"} 
      * node_disk_read_bytes_total{device="sda"} 
      * node_disk_read_time_seconds_total{device="sda"} 
      * node_disk_write_time_seconds_total{device="sda"}
    
   * **Network**
      * node_network_receive_errs_total{device="eth0"} 
      * node_network_receive_bytes_total{device="eth0"} 
      * node_network_transmit_bytes_total{device="eth0"}
      * node_network_transmit_errs_total{device="eth0"}

1. Установил Netdata. После установки:
    * Заменил в конфигурационном файле `/etc/netdata/netdata.conf` в секции [global] значение с `127.0.0.1` на `0.0.0.0`
    * Добавил в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте `vagrant reload`
    * После успешной перезагрузки в браузере на хостовом ПК зашёл на `localhost:19999`:
    
        ![Proof](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-04-os-04.png) 

1. По выводу `dmesg` можно понять, определяет ли ОС, что загружена на ненастоящем оборудовании, а на системе виртуализации:
    
    ```
   [    0.000000] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
   [    0.000000] Hypervisor detected: KVM
   [    0.043248] Booting paravirtualized kernel on KVM
   [    2.169664] systemd[1]: Detected virtualization oracle.
   [    2.515716] vboxguest: Successfully loaded version 6.1.24 r145751
   [    2.515728] vboxguest: misc device minor 58, IRQ 20, I/O port d020, MMIO at 00000000f0400000 (size 0x400000)
   [    2.515729] vboxguest: Successfully loaded version 6.1.24 r145751 (interface 0x00010004)
   [    3.155484] 06:51:12.253305 main     VBoxService 6.1.24 r145751 (verbosity: 0) linux.amd64 (Jul 15 2021 18:33:29) release log
   [    3.155550] 06:51:12.253405 main     Executable: /opt/VBoxGuestAdditions-6.1.24/sbin/VBoxService
    ```
1. Стандартное значение параметра ядра `fs.nr_open` (максимальное количество открытых файлов в одном процессе) равно: **1048576** `ulimit -Hn` (Hard limit). Также есть ограничение в **1024** `ulimit -Sn` (Soft limit) которое не позволит достичь Hard limit. 
1. Запустил `sleep 1h` в отдельном неймспейсе процессов (перешёл в него):
   
   ![Proof](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-04-os-05.png) 

1.  * Команда `:(){ :|:& };:` это так называемая "fork-bomb":
    ```
    определяет функцию с именем : 
    которая вызывает себя дважды (Код: : | : )
    это происходит в фоновом режиме ( & )
    после ; определение функции выполнено
    и функция : запускается
    ```    

    * Запустил эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04
    * Вызов `dmesg` показал:
      
      `[16963.274508] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-10.scope`
      
    * Помог механизм автоматической стабилизации в виде ограничения на максимальное количество процессов в слайсе текущего пользователя с id 1000. 
    * Максимальное количество процессов по-умолчанию **3571**, для изменения число процессов необходимо выполнить команду `ulimit -u 200`, например.
