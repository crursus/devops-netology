# Домашнее задание к занятию "5.4. Практические навыки работы с Docker"

1.  * Изменил базовый образ предложенного Dockerfile на Arch Linux c сохранением его функциональности:
    
        ```text
        FROM archlinux:latest
        
        RUN yes | pacman -Syu ponysay
        
        ENTRYPOINT ["/usr/bin/ponysay"]
        CMD ["Hey, netology”]
        ```
    * Прикладываю:
        - [Dockerfile](https://github.com/crursus/devops-netology/blob/main/homeworks/05-virt-04-docker-practical-skills/dockerfile)
        - Скриншот вывода командной строки после запуска контейнера из вашего базового образа
          
            ![proof01](https://github.com/crursus/devops-netology/blob/main/images/proof-05-virt-04-docker-practical-skills-01.png)
        - [Ссылка на хранилище hub.docker.com](https://hub.docker.com/r/crursus/kaa-al-ponysay "crursus/kaa-al-ponysay")

---

2.  * Составил 2 Dockerfile'а:
    
        * Первый образ на *amazoncorreto* kaa-jenkins:ver1:
            - Присвоил образу тэг `ver1` 
    
        * Второй образ на *ubuntu:latest* kaa-jenkins:ver2:
            - Присвоил образу тэг `ver2`
    * Собрал 2 образа по полученным Dockerfile:
        ```shell
        docker build -t crursus/kaa-jenkins:ver1 -f 1.dockerfile .
        docker build -t crursus/kaa-jenkins:ver2 -f 2.dockerfile .
        ```
    * Запустил и проверил их работоспособность
        ```shell
        docker run -itd -p 8080:8080 --name kaa-jenkins1 crursus/kaa-jenkins:ver1
        docker run -itd -p 8080:8080 --name kaa-jenkins2 crursus/kaa-jenkins:ver2
        ```      
    * Опубликовал образы в своём docker хранилище
        ```shell
        docker push crursus/kaa-jenkins:ver1
        docker push crursus/kaa-jenkins:ver2
        ```
    * Предоставляю:
        - Наполнения 2х Dockerfile из задания:
            1. [1.dockerfile](https://github.com/crursus/devops-netology/blob/main/homeworks/05-virt-04-docker-practical-skills/1.dockerfile)
            2. [2.dockerfile](https://github.com/crursus/devops-netology/blob/main/homeworks/05-virt-04-docker-practical-skills/2.dockerfile)
        - Скриншоты веб-интерфейса Jenkins запущенных вами контейнеров (достаточно 1 скриншота на контейнер)
            1. ![proof02](https://github.com/crursus/devops-netology/blob/main/images/proof-05-virt-04-docker-practical-skills-02.png)
            2. ![proof03](https://github.com/crursus/devops-netology/blob/main/images/proof-05-virt-04-docker-practical-skills-03.png)
        - Скриншоты логов запущенных вами контейнеров (из командной строки)
            1. ![proof04](https://github.com/crursus/devops-netology/blob/main/images/proof-05-virt-04-docker-practical-skills-04.png)
            2. ![proof05](https://github.com/crursus/devops-netology/blob/main/images/proof-05-virt-04-docker-practical-skills-05.png)
        - Ссылки на образы в вашем хранилище docker-hub
            1. [kaa-jenkins:ver1](https://hub.docker.com/layers/crursus/kaa-jenkins/ver1/images/sha256-e5349d4604a1c4d39655c6c6bbb9d1c181d4253ea373c1f503e28cab60e35556?context=explore) 
            2. [kaa-jenkins:ver2](https://hub.docker.com/layers/crursus/kaa-jenkins/ver2/images/sha256-2a51e093fbae845205d72add5eab0cfcd93ff4a99fc231d27130d083e441e1b5?context=explore)

---

3.  * Написал Dockerfile:
        - [node.dockerfile](https://github.com/crursus/devops-netology/blob/main/homeworks/05-virt-04-docker-practical-skills/node.dockerfile)
        - Использовал образ https://hub.docker.com/_/node как базовый
        - Собрал образ и запустил контейнер в фоновом режиме с публикацией порта
        ```shell
        docker build -t crursus/kaa-node:v1.0 -f node.dockerfile .
        docker run -d -p 3000:3000 --net=bridgetest --name kaa-node crursus/kaa-node:v1.0 npm start 172.18.0.2
        ```

    * Запустил второй контейнер из образа ubuntu:latest
        ```shell
        docker run -itd --name kaa-ubuntu ubuntu
        ```    
    * Подключил к созданной сети `bridgetest` контейнер `kaa-ubuntu`
        ```shell
        docker network connect bridgetest kaa-ubuntu
        ```    
    * Вывел список docker сетей
      ```shell
        docker network inspect bridgetest
        docker network ls -a
      ```
        ![proof06](https://github.com/crursus/devops-netology/blob/main/images/proof-05-virt-04-docker-practical-skills-06.png)
    
    * Запустил командную строку контейнера `ubuntu` в интерактивном режиме
      ```shell
        docker exec -it kaa-ubuntu bash
      ```
     * Используя утилиту `curl` вызвал путь `/` контейнера с npm приложением
        ```shell
        curl 172.18.0.2:3000/
        ```
        ![proof07](https://github.com/crursus/devops-netology/blob/main/images/proof-05-virt-04-docker-practical-skills-07.png)
