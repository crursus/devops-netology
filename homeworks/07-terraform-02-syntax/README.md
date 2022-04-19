### Домашнее задание к занятию "7.2. Облачные провайдеры и синтаксис Terraform."

1. (Вариант с Yandex.Cloud). Регистрация в aws и знакомство с основами (необязательно, но крайне желательно).
   * В рамках одного из предыдущих ДЗ уже был создан аккаунт Yandex.Cloud
   * В виде результата задания прикладываю вывод команды yc config list
   
     ![proof01](https://github.com/crursus/devops-netology/blob/main/images/proof-07-terraform-02-syntax-01.png)

---
2. Создание yandex_compute_instance через терраформ. 

   * Создал файл `main.tf` и `versions.tf`.
   * Зарегистрировал провайдера. В файл `main.tf` добавил блок `provider`, а в `versions.tf` блок `terraform` с вложенным блоком `required_providers`. Указал выбранный регион ``ru-central1-a`` внутри блока `provider`.
   * В файле `main.tf` создал ресурс 
3. Команда `terraform plan` выполняется без ошибок. 
![proof02](https://github.com/crursus/devops-netology/blob/main/images/proof-07-terraform-02-syntax-02.png)
   * В качестве результата задания предоставляю:
     - Ответ на вопрос: Для создания своего образ ami можно использовать ``Packer``
     - Ссылку на репозиторий с исходной конфигурацией терраформа: [Конфигурация](https://github.com/crursus/devops-netology/)
