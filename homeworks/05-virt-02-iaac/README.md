
# Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"

1. 
  * Основные преимущества применения на практике IaaC паттернов:
    * Возможность использования шаблонов, снижение трудозатрат на повторяющиеся задач;
    * Более частое тестирование и соответственно раннее обнаружение ошибок;
    * Масштабируемость;
    * Контроль версий;
    * Непрерывность процессов;
    * Централизация вносимых изменений.
  * Считаю что основополагающим принципом IaaC является **идемпотентность**. Идентичность результата при применении одинаковых операций на разных площадках. 

---
2. 
    * Оркестратор Ansible отличается от других систем управление конфигурациями использованием существующей SSH(PKI) инфраструктуры. Также может применяться на всех стадиях жизненного цикла инфраструктуры проектов.
    * На мой взгляд **push** метод работы систем конфигурации более надёжный, так как рассылка идёт из центра, что подразумевает более строгий контроль за рассылаемыми конфигурациями. Так же если произошло какое-то глобальное изменение инфраструктуры, при pull методе, сервера просто не будут знать откуда запрашивать конфигурацию. 

---
3. Установил на личный компьютер. Прикладываю вывод команд установленных версий каждой из программ, оформленный в markdown:

   - VirtualBox
    ```commandline 
    PS C:\Program Files\Oracle\VirtualBox> .\VBoxManage.exe
    Oracle VM VirtualBox Command Line Management Interface Version 6.1.26 
    ```
   - Vagrant
    ```shell
    $ vagrant --version
    Vagrant 2.2.18
    ```
   - Ansible
    ```shell
    $ ansible --version
    ansible 2.8.4
      config file = /cygdrive/d/dev/vagrantconf/src/vagrant/ansible.cfg
      configured module search path = ['/home/Alexey/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
      ansible python module location = /usr/lib/python3.7/site-packages/ansible
      executable location = /usr/bin/ansible
      python version = 3.7.12 (default, Nov 23 2021, 18:58:07) [GCC 11.2.0]
    ```
---
4. Установил Ansible на Windows через cygwin. Обновил пакет через pip3 (был обновлён). При запуске выдаёт ошибку:
    ```shell
    ==> server1.netology: Running provisioner: ansible...
    Windows is not officially supported for the Ansible Control Machine.
    Please check https://docs.ansible.com/intro_installation.html#control-machine-requirements
    Vagrant gathered an unknown Ansible version:
    
    
    and falls back on the compatibility mode '1.8'.
    
    Alternatively, the compatibility mode can be specified in your Vagrantfile:
    https://www.vagrantup.com/docs/provisioning/ansible_common.html#compatibility_mode
        server1.netology: Running ansible-playbook...
    The Ansible software could not be found! Please verify
    that Ansible is correctly installed on your host system.
    
    If you haven't installed Ansible yet, please install Ansible
    on your host system. Vagrant can't do this for you in a safe and
    automated way.
    Please check https://docs.ansible.com for more information.
    ```
    Обновлю vagrant и box...
    Так же поставил качаться Ubuntu (WSL), попробую как будет время.
