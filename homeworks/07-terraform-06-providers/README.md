### Домашнее задание к занятию "7.6. Написание собственных провайдеров для Terraform."

1. 
Потренировался читать исходный код AWS провайдера: 
[https://github.com/hashicorp/terraform-provider-aws.git](https://github.com/hashicorp/terraform-provider-aws.git)


* Нашёл, где перечислены все доступные `resource` и `data_source`, прикладываю ссылку на эти строки в коде на 
гитхабе:
   * [resource](https://github.com/hashicorp/terraform-provider-aws/blob/cdd18afcf7882a318634d1456f3bf715e62b7342/internal/provider/provider.go#L890)
   * [data_source](https://github.com/hashicorp/terraform-provider-aws/blob/cdd18afcf7882a318634d1456f3bf715e62b7342/internal/provider/provider.go#L419)
* Для создания очереди сообщений SQS используется ресурс `aws_sqs_queue` у которого есть параметр `name`. 
    * Параметр `name` конфликтует (`ConflictsWith`) с параметром `name_prefix`. [Ссылка](https://github.com/hashicorp/terraform-provider-aws/blob/9c0b16cae61bf48eb76a19e089f823101600b4fc/internal/service/sqs/queue.go#L87)
    * Максимальная длина имени 80 символов. [Ссылка](https://github.com/hashicorp/terraform-provider-aws/blob/cdd18afcf7882a318634d1456f3bf715e62b7342/internal/service/sqs/queue.go#L427)
    * Имя должно подчиняться регулярному выражению: `[a-zA-Z0-9_-]` (могут быть буквы, цифры, дефис и нижнее подчёркивание) [Ссылка](https://github.com/hashicorp/terraform-provider-aws/blob/cdd18afcf7882a318634d1456f3bf715e62b7342/internal/service/sqs/queue.go#L427)
