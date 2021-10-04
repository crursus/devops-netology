# Домашнее задание к занятию "3.5. Файловые системы"

1. Прочитал о разрежённых файлах (sparse file).

1. Файлы, являющиеся жесткой ссылкой на один объект, не могут иметь разные права доступа и владельца, так как имеют одинаковый индексный дескриптор (inode) в котором хранится метаинформация.

1. Выполнил `vagrant destroy` на имеющийся инстанс Ubuntu. Заменил содержимое Vagrantfile требуемой конфигурацией.

1. Разбил первый диск на 2 раздела: 2 Гб и оставшееся пространство.

1. Перенёс данную таблицу разделов на второй диск:
   
   `sfdisk -d /dev/sdb | sfdisk /dev/sdc`

1. Собрал `mdadm` RAID1 на паре разделов 2 Гб:
   
   `mdadm --create --verbose /dev/md1 -l 1 -n 2 /dev/sdb1 /dev/sdc1`

1. Собрал `mdadm` RAID0 на второй паре маленьких разделов:

   `mdadm --create --verbose /dev/md1 -l 0 -n 2 /dev/sdb2 /dev/sdc2`

1. Создал 2 независимых PV на получившихся md-устройствах:

   `pvcreate /dev/md1 /dev/md0`

1. Создал общую volume-group на этих двух PV:

   `vgcreate vg0 /dev/md1 /dev/md0`

1. Создал LV размером 100 Мб, указав его расположение на PV с RAID0:

   `lvcreate -L 100M -n lv0 /dev/vg0 /dev/md0`

1. Создал `mkfs.ext4` ФС на получившемся LV:

   `mkfs.ext4 -L tst_lv0 /dev/vg0/lv0`

1. Смонтировал этот раздел в директорию, `/tmp/tst_mnt`:

   ```bash
   mkdir /tmp/tst_mnt
   mount /dev/vg0/lv0 /tmp/tst_mnt/
   ```

1. Поместил тестовый файл:
   
   ```bash
   wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
   ```
   
1. Прикрепил вывод `lsblk`:

   ![Proof](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-04-fs-01.png) 

1. Протестировал целостность файла:

   ```bash
   gzip -v -t test.gz
   test.gz:         OK
    ```

1. Используя pvmove, переместил содержимое PV с RAID0 на RAID1:

   ```bash
   pvmove /dev/md0 /dev/md1
   /dev/md0: Moved: 24.00%
   /dev/md0: Moved: 100.00%
   ```

1. Сделал `--fail` на устройство /dev/sdc1 в RAID1 md:

   ```bash
   mdadm /dev/md1 --fail /dev/sdc1
   ```

1. Подтверждение вывода `dmesg`, что RAID1 работает в деградированном состоянии:

   ![Proof](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-04-fs-02.png)

1. Протестировал целостность файла, продолжает быть доступен:

   ```bash
   gzip -v -t test.gz
   test.gz:         OK
   ```

1. Погасите тестовый хост, `vagrant destroy`.
 