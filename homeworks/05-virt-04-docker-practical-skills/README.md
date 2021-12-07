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

2.  * Составил 2 Dockerfile:
    
        * Первый образ *amazoncorreto*:
            - Присвоил образу тэг `ver1` 
    
        * Второй образа *ubuntu:latest*:
            - Присвоил образу тэг `ver2`
    * Собрал 2 образа по полученным Dockerfile:
        ```shell
        docker build -t crursus/kaa-jenkins:ver1 -f 1.dockerfile .
        docker build -t crursus/kaa-jenkins:ver2 -f 2.dockerfile .
        ```
    * Запустил и проверил их работоспособность
        ```shell
        docker run -itd -p 8080:8080 --name kaa-jenkins1 crursus/kaa-jenkins:ver1
        docker build -t crursus/kaa-jenkins:ver2 -f 2.dockerfile .
        ```      
    * Опубликовал образы в своём docker хранилище
        ```shell
        docker push crursus/kaa-jenkins:ver1
        docker build -t crursus/kaa-jenkins:ver2 -f 2.dockerfile .
        ```
    * Предоставляю:
        - Наполнения 2х Dockerfile из задания:
            1. [1.dockerfile](https://github.com/crursus/devops-netology/blob/main/homeworks/05-virt-04-docker-practical-skills/1.dockerfile)
            2. [2.dockerfile](https://github.com/crursus/devops-netology/blob/main/homeworks/05-virt-04-docker-practical-skills/2.dockerfile)
        - Скриншоты веб-интерфейса Jenkins запущенных вами контейнеров (достаточно 1 скриншота на контейнер)
            1. ![proof01](https://github.com/crursus/devops-netology/blob/main/images/proof-05-virt-04-docker-practical-skills-02.png)
            2.
        - Скриншоты логов запущенных вами контейнеров (из командной строки)
            1.  
            2.
        - Ссылки на образы в вашем хранилище docker-hub
            1. 
            2. 

## Задача 3 

В данном задании вы научитесь:
- объединять контейнеры в единую сеть
- исполнять команды "изнутри" контейнера

Для выполнения задания вам нужно:
- Написать Dockerfile: 
    - Использовать образ https://hub.docker.com/_/node как базовый
    - Установить необходимые зависимые библиотеки для запуска npm приложения https://github.com/simplicitesoftware/nodejs-demo
    - Выставить у приложения (и контейнера) порт 3000 для прослушки входящих запросов  
    - Соберите образ и запустите контейнер в фоновом режиме с публикацией порта

- Запустить второй контейнер из образа ubuntu:latest 
- Создайть `docker network` и добавьте в нее оба запущенных контейнера
- Используя `docker exec` запустить командную строку контейнера `ubuntu` в интерактивном режиме
- Используя утилиту `curl` вызвать путь `/` контейнера с npm приложением  

Для получения зачета, вам необходимо предоставить:
- Наполнение Dockerfile с npm приложением
- Скриншот вывода вызова команды списка docker сетей (docker network cli)
- Скриншот вызова утилиты curl с успешным ответом

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
