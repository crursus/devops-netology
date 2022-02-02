# Домашнее задание к занятию "5.5. Оркестрация кластером Docker контейнеров на примере Docker Swarm"


1. 
    * Отличие режимов работы сервисов в Docker Swarm кластере (replication и global) в масштабе развёртываемых сервисов. В режиме **global** сервис реплицируется на все узлы (ноды) swarm-сети (по одному на каждый новый). В режиме **replicated** сервис реплицируется указанное количество раз на один или несколько узлов swarm-сети (если есть узлы). 
    * Для [выбора лидера](http://thesecretlivesofdata.com/raft/#election "Leader election") используется **алгоритм консенсуса Raft**:
   
      Если обычный узел (последователь) долго не получает сообщений от лидера, то он переходит в состояние «кандидат» и посылает другим узлам запрос на голосование. Другие узлы голосуют за того кандидата, от которого они получили первый запрос. Если кандидат получает сообщение от лидера, то он снимает свою кандидатуру и возвращается в обычное состояние. Если кандидат получает большинство голосов, то он становится лидером. Если же он не получил большинства (это случай, когда на кластере возникли сразу несколько кандидатов и голоса разделились), то кандидат ждёт случайное время и инициирует новую процедуру голосования.
      
    * **Overlay Network** - это сеть, создаваемая поверх другой сети. Применительно к Docker управляет соединениями между сервисами участвующими в сети Swarm (IPSEC туннели между нодами на уровне VXLAN).
---      
2. Создал свой первый Docker Swarm кластер в Яндекс.Облаке.
    * Создал сеть и подсеть:
      ```shell
        yc vpc network create --name net --labels my-label=netology --description "test network"
        yc vpc subnet create --name my-subnet-a --zone ru-central1-a --range 10.1.2.0/24 --network-name net --description "test subnet"
      ```
    * Создал собственный образ операционной системы с помощью Packer:
      ```shell
        packer validate centos-7-base.json
        packer build centos-7-base.json
      ```
    * Удалил сеть и подсеть после сборки образа ОС:
      ```shell
        yc vpc subnet delete --name my-subnet-a      
        yc vpc network delete --name net
      ```
    * Создал компонент мониторинга, состоящий из стека микросервисов:  
      ```shell
        chmod 770 terraform
        terraform init
        terraform validate
        terraform plan
        terraform apply -auto-approve
      ```

    * Скриншот из терминала, с выводом команды:
       ```shell
         docker node ls
       ```
       ![proof01](https://github.com/crursus/devops-netology/blob/main/images/proof-05-virt-05-docker-swarm-01.png)

---
3. 
    * Скриншот из терминала (консоли), с выводом команды:
       ```shell
         docker service ls
       ```
       ![proof02](https://github.com/crursus/devops-netology/blob/main/images/proof-05-virt-05-docker-swarm-02.png)
---
4. (*) Выполнил на лидере Docker Swarm кластера команду:
    *  ```shell
         docker swarm update --autolock=true
       ```
       Команда выполняет включение **автоблокировки** в существующей swarm-сети. **Автоблокировка** в свою очередь позволяет повысить безопасность, требуя при перезапуске докера вручную провести разблокировку, для загрузки взаимных TLS ключей шифрования и ключей шифрования(дешифрования) логов Raft.   
    * После перезагрузки docker потребовалось ввести команду разблокировки и ключ шифрования 
       ```shell
         docker swarm unlock
       ```