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

1. Установите в свою виртуальную машину [Netdata](https://github.com/netdata/netdata). Воспользуйтесь [готовыми пакетами](https://packagecloud.io/netdata/netdata/install) для установки (`sudo apt install -y netdata`). После успешной установки:
    * в конфигурационном файле `/etc/netdata/netdata.conf` в секции [web] замените значение с localhost на `bind to = 0.0.0.0`,
    * добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте `vagrant reload`:

    ```bash
    config.vm.network "forwarded_port", guest: 19999, host: 19999
    ```

    После успешной перезагрузки в браузере *на своем ПК* (не в виртуальной машине) вы должны суметь зайти на `localhost:19999`. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.

1. Можно ли по выводу `dmesg` понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?
1. Как настроен sysctl `fs.nr_open` на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (`ulimit --help`)?
1. Запустите любой долгоживущий процесс (не `ls`, который отработает мгновенно, а, например, `sleep 1h`) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через `nsenter`. Для простоты работайте в данном задании под root (`sudo -i`). Под обычным пользователем требуются дополнительные опции (`--map-root-user`) и т.д.
1. Найдите информацию о том, что такое `:(){ :|:& };:`. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (**это важно, поведение в других ОС не проверялось**). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов `dmesg` расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

 
 ---

## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Также вы можете выполнить задание в [Google Docs](https://docs.google.com/document/u/0/?tgif=d) и отправить в личном кабинете на проверку ссылку на ваш документ.
Название файла Google Docs должно содержать номер лекции и фамилию студента. Пример названия: "1.1. Введение в DevOps — Сусанна Алиева".

Если необходимо прикрепить дополнительные ссылки, просто добавьте их в свой Google Docs.

Перед тем как выслать ссылку, убедитесь, что ее содержимое не является приватным (открыто на комментирование всем, у кого есть ссылка), иначе преподаватель не сможет проверить работу. Чтобы это проверить, откройте ссылку в браузере в режиме инкогнито.

[Как предоставить доступ к файлам и папкам на Google Диске](https://support.google.com/docs/answer/2494822?hl=ru&co=GENIE.Platform%3DDesktop)

[Как запустить chrome в режиме инкогнито ](https://support.google.com/chrome/answer/95464?co=GENIE.Platform%3DDesktop&hl=ru)

[Как запустить  Safari в режиме инкогнито ](https://support.apple.com/ru-ru/guide/safari/ibrw1069/mac)

Любые вопросы по решению задач задавайте в чате Slack.

---
