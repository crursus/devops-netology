# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательные задания

1. В приведённом скрипте:
	* При таких типах данных (int, str) значение не будет присвоено переменной **c** (интерпретатор выдаёт ошибку не поддерживаемых типах операнда для `+` ). 
	* Для получения значения переменной **с** - 12, потребуется определить строкой **a** = '1'
	* Для получения значения переменной **с** - 3, потребуется определить  **b** = 2

1. Доработал скрипт ниже:

	```python
	#!/usr/bin/env python3
	import os
	bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
	result_os = os.popen(' && '.join(bash_command)).read()
    # is_change = False Неиспользуемая переменная
	for result in result_os.split('\n'):
        if result.find('modified') != -1:
            prepare_result = result.replace('\tmodified:   ', '')
            print(prepare_result)
    #       break выход из цикла по достижения первого условия 
	```

1. Доработал скрипт, чтобы он мог воспринимать путь к репозиторию, который мы передаём как входной параметр. Также реализовал проверку, является ли директория поступающая в качестве аргумента локальным репозиторием:

	```python
	#!/usr/bin/env python3
	
	import os
	import sys
	
	bash_arg = sys.argv[1]
	#bash_arg = str('d:/dev/git/devops-netology/') Проверял на локальном 
	
	if (os.access(bash_arg+'/.git', os.F_OK) and os.path.exists(bash_arg)):
    	print('Найден локальный репозиторий GIT по заданному пути')
	else:
    	exit('Не найден локальный репозиторий GIT по заданному пути')
	
	bash_command = ['cd '+bash_arg, 'git status']
	result_os = os.popen(' && '.join(bash_command)).read()
	for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', ' ')
        print(prepare_result)
	```
 	![proof01](https://github.com/crursus/devops-netology/blob/main/images/proof-04-script-02-py-001.png)
   

1. Написал скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки:
	```python
	#!/usr/bin/env python3
	import socket
	import os
	import datetime
	
	hostnames_arg = ['drive.google.com', 'mail.google.com', 'google.com', 'ya.ru']
	
	if os.path.exists('check_db'):
	    file = open('check_db', 'r')
	    chk_dict = {}
	
	    rows = file.read().split('  ')
	    print(rows)
	    del rows[-1]
	
	    for row in rows:
	        url = row.split(' ')[0]
	        ip = row.split(' ')[1]
	        chk_dict[url] = ip
	    file.close()
	else:
	    print('Проверка не производилась, не с чем сравнивать')
	    chk_dict = {'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0', 'ya.ru': '0.0.0.0'}
	
	output = ''
	file1 = open('check_db', 'w')
	for url in hostnames_arg:
	    ip = socket.gethostbyname(url)
	    output = output+url+' '+ip+'  '
	    if chk_dict[url] == ip:
	        print(str(datetime.datetime.now())+' '+url+' '+ip)
	    else:
	        print(str(datetime.datetime.now())+' [ERROR] '+url+' IP mismatch: '+chk_dict[url]+' '+ip)
	file1.write(output)
	file1.close()
 	```
	![proof02](https://github.com/crursus/devops-netology/blob/main/images/proof-04-script-02-py-002.png)
	![proof03](https://github.com/crursus/devops-netology/blob/main/images/proof-04-script-02-py-003.png)
