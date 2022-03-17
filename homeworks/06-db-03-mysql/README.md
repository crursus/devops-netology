# Домашнее задание к занятию "6.3. MySQL"

1. 
   * Используя docker поднял инстанс MySQL (версию 8) c volume, 
   в который будут складываться данные БД (data):
   ```shell
      sudo docker run -d --name kaa-mysql -p 3306:3306 -v ~/devops/docker/mysql/test_data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mysql mysql:8.0
   ```
   * Перешёл в управляющую консоль `mysql` внутри контейнера и используя команду `\h` получил список управляющих команд.
   * Создал таблицу `test_db` и восстановил содержимое из дампа `test_dump.sql`:
   ```shell
      sudo docker exec -it kaa-mysql bash
      mysql -uroot -pmysql
      create database test_db;
      \! mysql -uroot -pmysql test_db < test_dump.sql
   ```
   * Нашёл команду для выдачи статуса БД ``/s``. Из её вывода версия сервера БД: **8.0.28**.
    
     ![proof01](https://github.com/crursus/devops-netology/blob/main/images/proof-06-db-03-mysql-01.png)
   * Подключился к восстановленной БД и получил список таблиц из этой БД. Привёл количество записей с `price` > 300:
   ```shell
      use test_db;
      show tables;
      describe orders;
      select count(*) from orders where price > 300;
   ```
   
      ![proof02](https://github.com/crursus/devops-netology/blob/main/images/proof-06-db-03-mysql-02.png)

---

2. 
    * Создал пользователя test в БД c паролем test-pass, используя плагин авторизации mysql_native_password:
    ```shell
      create user 'test'@'localhost' identified with mysql_native_password by 'test-pass'
      password expire interval 180 day
      failed_login_attempts 3
      with max_queries_per_hour 100
      attribute '{"name": "james", "surname": "pretty"}';
    ```
    * Предоставил привилегии пользователю `test` на операции SELECT базы `test_db`.
    ```shell
      grant select on test_db.* to 'test'@'localhost';
    ```
    * Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test`
    ```shell
      select * from information_schema.user_attributes where user = 'test' and host = 'localhost';
    ```

      ![proof03](https://github.com/crursus/devops-netology/blob/main/images/proof-06-db-03-mysql-03.png)

---

3. 
    * Установил профилирование `SET profiling = 1`:
    ```shell
      set profiling = 1;
    ```
    * Изучил вывод профилирования команд:
    ```shell
      show profiles;
    ```
    * Исследовал какой `engine` используется в таблице БД `test_db`:
    ```shell
      select table_name, engine from information_schema.tables where table_schema = 'test_db';
    ```
    * Изменил `engine`:
      - на `MyISAM`
      ```shell
       alter table orders engine = myisam;
      ```
      - на `InnoDB`
      ```shell
       alter table orders engine = innodb;
      ```
                
    * Привёл время выполнения и запрос на изменения из профайлера `show profiles;`:
   
      ![proof04](https://github.com/crursus/devops-netology/blob/main/images/proof-06-db-03-mysql-04.png)
---

4. Изучил файл `my.cnf` в директории /etc/mysql.
    * Изменил его согласно ТЗ (движок InnoDB) добавил строки:
      - Скорость IO важнее сохранности данных
      ```shell
      innodb_flush_log_at_trx_commit = 0
      ```
      - Нужна компрессия таблиц для экономии места на диске
      ```shell
      innodb_file_per_table = 1
      innodb_compression_level = 9
      ```
      - Размер буфера с незакомиченными транзакциями 1 Мб (Может Мебибайт?)
      ```shell
      innodb_log_buffer_size = 1048576
      ```
      - Буфер кеширования 30% от ОЗУ (4GiB)
      ```shell
      innodb_buffer_pool_size = 1288490188
      innodb_buffer_pool_instances = 1
      ```
      - Размер файла логов операций 100 МиБ (MiB)
      ```shell
      innodb_log_file_size = 104857600
      ```
   * Привожу в ответе измененный файл `my.cnf`:
   
     ![proof05](https://github.com/crursus/devops-netology/blob/main/images/proof-06-db-03-mysql-05.png)