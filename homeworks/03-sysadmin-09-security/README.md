# Домашнее задание к занятию "3.9. Элементы безопасности информационных систем"

1. * Установил [Hashicorp Vault](https://learn.hashicorp.com/vault) в виртуальной машине Vagrant/VirtualBox
   * Пробросил порт Vault (8200) на localhost
   * Добавил к опциям запуска `-dev-listen-address="0.0.0.0:8200"`:
   
      ![proof01](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-09-sec-01.png)
1. * Запустил Vault-сервер в dev-режиме c UI:
   
      ![proof02](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-09-sec-02.png)
      
      ![proof03](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-09-sec-03.png)
      
   * Добавил токен: `export VAULT_TOKEN=s.z2z8XcboKtaG6ctzpbp9fpNA`
1. Cоздал Root CA и Intermediate CA используя [PKI Secrets Engine](https://www.vaultproject.io/docs/secrets/pki):
   
   ```shell
   apt -y install jq
   ```
   
   ```shell
   vault secrets enable pki
   vault secrets tune -max-lease-ttl=87600h pki
   vault write -field=certificate pki/root/generate/internal \
   common_name="example.com" \
   ttl=87600h > CA_cert.crt
   
   vault write pki/config/urls \
   issuing_certificates="http://127.0.0.1/v1/pki/ca" \
   crl_distribution_points="http://127.0.0.1/v1/pki/crl"  
   ```
   
   ```shell
   vault secrets enable -path=pki_int pki
   vault secrets tune -max-lease-ttl=43800h pki_int
   vault write -format=json pki_int/intermediate/generate/internal \
     common_name="example.com Intermediate Authority" \
     | jq -r '.data.csr' > pki_intermediate.csr
  
   vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \
     format=pem_bundle ttl="43800h" \
     | jq -r '.data.certificate' > intermediate.cert.pem

   vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem
   
   vault write pki_int/roles/example-dot-com \
     allowed_domains="example.com" \
     allow_subdomains=true \
     max_ttl="720h"
   ```
  
1. Подписал Intermediate CA csr на сертификат для тестового домена (`netology.example.com`):
   ```shell
   vault write -format=json pki_int/issue/example-dot-com common_name="netology.example.com" ttl="24h" > netology.example.com.txt
   ```   
      
      ![proof04](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-09-sec-04.png)
   
   ```shell
   cat netology.example.com.txt | jq -r .data.certificate > netology.example.com.pem
   cat netology.example.com.txt | jq -r .data.issuing_ca >> netology.example.com.pem
   cat netology.example.com.txt | jq -r .data.private_key > netology.example.com.key
   ```  
   
1. Установил на localhost nginx, сконфигурировал default vhost для использования подписанного Vault Intermediate CA сертификата и выбранного домена. Сертификат скопировал в nginx:
   
   ![proof05](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-09-sec-05.png)
   
   ![proof06](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-09-sec-06.png)   
      
1. Модифицировал `/etc/hosts` и [системный trust-store](http://manpages.ubuntu.com/manpages/focal/en/man8/update-ca-certificates.8.html) `update-ca-certificates`, добился безошибочной с точки зрения HTTPS работы curl на ваш тестовый домен (отдающийся с localhost). Добавил в доверенные сертификаты Intermediate CA
   
   `curl -I --proto https https://netology.example.com`
   
   ![proof07](https://github.com/crursus/devops-netology/blob/main/images/proof-03-sa-09-sec-07.png)

1. Ознакомился с протоколом ACME и CA Let's encrypt. Попробую сделать.

