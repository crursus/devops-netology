### Домашнее задание занятия "5.2. Применение принципов IaaC в работе с виртуальными машинами"
4. (*) 
   * Установил VMware Workstation 16 Player. Отключил WSL. Создал ВМ и установил Ubuntu Desktop 21.10. Установил virtualbox, vagrant, ansible внутри ВМ. 
   * Создал ВМ запуском на исполнение файла конфигурации Vagrantfile.
   * Зашёл внутрь ВМ, убедился, что Docker установлен с помощью команд:
    ```shell
   vagrant@server1:~$ docker ps
   CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
   vagrant@server1:~$ docker --version
   Docker version 20.10.12, build e91ed57
   vagrant@server1:~$
    ```
### Домашнее задание к занятию "5.4. Оркестрация группой Docker контейнеров на примере Docker Compose"

1. 
    * Установил **docker-compose**:
      ```shell
      curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
      sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
      sudo apt-get update && sudo apt-get install packer
      ```
    * Активировал промокод из письма. Установил и настроил CLI **Yandex Cloud**:
      ```shell
      curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
      yc init
      yc config list
      yc compute image list
      yc vpc network create --name net --labels my-label=netology --description "my first network via yc"
      yc vpc subnet create --name my-subnet-a --zone ru-central1-a --range 10.1.2.0/24 --network-name net --description "my first subnet via yc"
      ```
    * Установил Terraform
       ```shell
      sudo apt-get update && sudo apt-get install terraform
       ```
    * Создал собственный образ операционной системы с помощью Packer:
       ```shell
      packer validate centos-7-base.json
      
       ```
      ![proof01](https://github.com/crursus/devops-netology/blob/main/images/proof-05-virt-04-docker-compose-01.png)
    
---
2. 
   * Создал сервисную учётную запись:
      ```shell
      yc iam service-account create --name kaa-yc
      ```   
   * Сгенерировал ключ для учётной записи:
      ```shell
      yc iam key create --service-account-id ajevi9l5d8dok98i5o9a -o key.json
      ```
   * Создал SSH ключи:
      ```shell
      ssh-keygen
      ```
   * Создал первую виртуальную машину в **Yandex Cloud**. В файле provider.tf Заменил параметр `service_account_key_file = "key.json"` на `token = "my-token"` 
      ```shell
      terraform init
      terraform plan
      terraform apply -auto-approve
      ```
  
       ![proof01](https://github.com/crursus/devops-netology/blob/main/images/proof-05-virt-04-docker-compose-02.png)
    
---
3. 

   * Создал первый готовый к боевой эксплуатации компонент мониторинга, состоящий из стека микросервисов:
      ```shell
      ansible-playbook provision.yml
      ```
     ![proof01](https://github.com/crursus/devops-netology/blob/main/images/proof-05-virt-04-docker-compose-03.png)
   