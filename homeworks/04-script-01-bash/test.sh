#!/usr/bin/env bash
	a=1
 	array_ip=(127.0.0.1 172.28.128.10 172.28.128.31)
	while ((1==1))
 	do
 	  echo ---- Начало проверки № $a ---- | tee -a test.log
 	  date
 	  for i in ${array_ip[@]}
 	  do
 	    curl -I $i:80 >> test.log
 	  done
 	  if (($? == 0))
      then
        echo ---- Конец проверки № $a ---- | tee -a test.log
    else
        echo Хост $i не отвечает | tee -a error.log
        echo ---- Конец всех проверок ---- | tee -a test.log
        break
    fi
    let "a += 1"
 	  sleep 5
 	done
