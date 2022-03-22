# Домашнее задание к занятию "6.4. PostgreSQL"

1. 
    * Используя docker запустил инстанс PostgreSQL (версию 13). Данные БД сохранил в volume. 
    ```shell
      sudo docker run -d --name kaa-pg13 -p 5432:5432 -v ~/devops/docker/volume/postgres13/data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=test postgres:13
    ```
    * Подключился к БД PostgreSQL используя `psql`:
    ```shell
      sudo docker exec -it kaa-pg13 psql --username=postgres --dbname=postgres
    ```
    * Воспользовался командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам. Нашёл и привожу управляющие команды для:
      - вывода списка БД - `\list`
      - подключения к БД - `\connect`
      - вывода списка таблиц - `\dtS`
      - вывода описания содержимого таблиц - `\d NAME`
      - выхода из psql - `\q`
      
---

2.
    * Используя `psql` создал БД `test_database`:
    ```shell
      create database "test_database";
    ```
    * Изучил бэкап БД. Восстановил бэкап БД в `test_database`:
    ```shell
      \! psql -U postgres -d test_database < /var/lib/postgresql/data/test_dump.sql;
    ```
    * Подключился к восстановленной БД и провёл операцию ANALYZE для сбора статистики по таблице:
    ```shell
      \c test_database;
      analyze orders;
    ```
    * Используя таблицу pg_stats, нашёл столбец таблицы `orders` с наибольшим средним значением размера элементов в байтах.
      Привёл в ответе команду, которую использовал для вычисления и полученный результат:
    ```shell
      select attname as column, avg_width as max_avg_size from pg_stats where avg_width = (select max(avg_width) from pg_stats where tablename='orders');
    ```
      ![proof01](https://github.com/crursus/devops-netology/blob/main/images/proof-06-db-04-postgresql-01.png)

---

3.
    * Произвёл секционирование таблицы на 2 (`orders_less_equal499` - price<=499 и `orders_more499` - price>499), исключает "ручное" разбиение при проектировании таблицы orders:
    ```shell
      alter table orders rename to orders_nonsect;
      create table orders (id integer, title text, price integer) partition by range(price);
      create table orders_less_equal499 partition of orders for values from (minvalue) to (499);
      create table orders_more499 partition of orders for values from (499) to (maxvalue);
      insert into orders (id, title, price) select * from orders_nonsect;
    ```
---

4. 
    * Используя утилиту `pg_dump` создал бекап БД `test_database`:
    ```shell
      \! pg_dump -U postgres -d test_database > /var/lib/postgresql/data/test_database_backup.sql;
    ```
    * Добавил параметр уникальность значения столбца `title` для таблиц `test_database` в бекап БД:
    ```shell
      CREATE TABLE public.orders (
      id integer NOT NULL,
      title character varying(80) NOT NULL,
      price integer DEFAULT 0,
      UNIQUE (title)
      );
    ```