# Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3"

1. В соответствии с логикой программы при работе балансировщика `ipvs` (директора), в режиме прямой маршрутизации (DR), ответ от реального сервера минует сервер балансировки. И соответственно директор не знает статуса TCP-соединения реального сервера с клиентом. И так как HTTP сразу закрывает соединение, запись в столбце `InActConn` будет видна пока не истечёт время ожидания соединения 

1. Подготовил и сконфигурировал через [vagrantconf](https://github.com/crursus/devops-netology/blob/main/homeworks/03-sysadmin-08-net/Vagrantfile) 5 ВМ:
    > Пока не получилось передать файл конфигурации в box VM 

    |Имя|IP-адрес|
    |:---:|:---:|      
    |kaa-cl|172.28.128.10|
    |kaa-bl1|172.28.128.21|
    |kaa-bl2|172.28.128.22|
    |kaa-srv1|172.28.128.31|
    |kaa-srv2|172.28.128.32|
    
    1. Модифицировал файл [keepalived.conf](https://github.com/crursus/devops-netology/blob/main/homeworks/03-sysadmin-08-net/keepalived.conf)
    1. Проверил статус `keepalived`:

        ![proof01](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-08-net-01.png)
    
        ![proof02](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-08-net-02.png)
    1. Вывод `ipvsadm -Ln` до отправки запросов:

        ![proof03](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-08-net-03.png)

        ![proof04](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-08-net-04.png)
    
        ![proof05](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-08-net-05.png)
    
        ![proof06](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-08-net-06.png)

    1. Получил 100 ответов выполнив `for i in {1..100}; do curl -I -s http://172.28.128.200>/dev/null; done`. Балансировка работает с **kaa-lb1**:

        ![proof07](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-08-net-07.png)

        ![proof08](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-08-net-08.png)

        ![proof09](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-08-net-07.png)

        ![proof10](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-08-net-08.png)

    1. Выполнил имитацию отказа остановив `keeplived` на **kaa-lb1** `systemctl stop keepalived`, проверил работу на **kaa-lb2**, отправив 100 запросов с **kaa-cl**:

        ![proof11](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-08-net-09.png)

        ![proof12](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-08-net-07.png)

        ![proof13](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-08-net-08.png)
      
1. Если при 3 Virtual IP будут потери, значит 4 VIP должно хватить (С учётом обсуждения в чате).

    > Может быть есть какие-то универсальные методики расчёта?