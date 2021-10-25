# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"

## Обязательные задания

1. Исправил ошибки в файле JSON (расставил кавычки):
	```json
	{
	    "info": "Sample JSON output from our service\t",
	    "elements": [
	        {
	            "name": "first",
	            "type": "server",
	            "ip": "7175"
	        },
	        {
	            "name": "second",
	            "type": "proxy",
	            "ip": "71.78.22.43"
	        }
	    ]
	}
	```

2. Модифицировал скрипт из прошлого ДЗ
	```python
	  #!/usr/bin/env python3
	  
	  import socket
	  import os
	  import datetime
	  import json
	  import yaml
	  
	  hostnames_arg = ['drive.google.com', 'mail.google.com', 'google.com', 'ya.ru']
	  if os.path.exists('check_db'): # & (os.stat('check_db')): добавить проверок
	      file = open('check_db', 'r')
	      chk_dict = {}
	      rows = file.read().split('  ')
	      del rows[-1] # поправить
	      for row in rows:
	          url = row.split(' ')[0]
	          ip = row.split(' ')[1]
	          chk_dict[url] = ip
	      file.close()
	  else:
	      print('Проверка не производилась, не с чем сравнивать')
	      chk_dict = {'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0', 'ya.ru': '0.0.0.0'}
	      file = open('check_db', 'w')
	      file.write('')
	      file.close()
	  output = ''
	  file1 = open('check_db', 'w')
	  json_out = ''
	  json_file = open('test.json', 'w')
	  yaml_out = ''
	  yaml_file = open('test.yml', 'w')
	  for url in hostnames_arg:
	      ip = socket.gethostbyname(url)
	      output = output+url+' '+ip+'  '
	      json_out = json_out+' '+json.dumps({url: ip})
	      yaml_out = yaml_out+' '+yaml.dump({url: ip})
	      if chk_dict[url] == ip:
	          print(str(datetime.datetime.now())+' '+url+' '+ip)
	      else:
	          print(str(datetime.datetime.now())+' [ERROR] '+url+' IP mismatch: '+chk_dict[url]+' '+ip)
	  file1.write(output)
	  file1.close()
	  json_file.write(json_out)
	  json_file.close()
	  yaml_file.write(yaml_out)
	  yaml_file.close()
	```
	![proof01](https://github.com/crursus/devops-netology/blob/main/images/proof-04-script-03-yaml-01.png)
   
	[test.json](https://github.com/crursus/devops-netology/blob/main/homeworks/04-script-03-yaml/test.json
   
    [test.yml](https://github.com/crursus/devops-netology/blob/main/homeworks/04-script-03-yaml/test.yml