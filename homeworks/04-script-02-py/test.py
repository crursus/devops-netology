#!/usr/bin/env python3

import socket
import os
import datetime

hostnames_arg = ['drive.google.com', 'mail.google.com', 'google.com', 'ya.ru']

if os.path.exists('check_db'): #добавить проверок
    file = open('check_db', 'r')
    chk_dict = {}

    rows = file.read().split('  ')
    print(rows)
    # поправить
    del rows[-1]

    for row in rows:
        url = row.split(' ')[0]
        ip = row.split(' ')[1]
        chk_dict[url] = ip
    file.close()
else:
    print('Проверка не производилась, не с чем сравнивать')
    chk_dict = {'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0', 'ya.ru': '0.0.0.0'}
#    file = open('check_db', 'w')
#    file.write('')
#    file.close()

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
