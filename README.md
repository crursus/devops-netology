#03-sysadmin-02-terminal
**Домашнее задание к занятию "3.2. Работа в терминале, лекция 2"**

1. Команда `cd` *встроенного* типа. Как я понимаю команда встроенная, так как используется только в рамках конкретной оболочки.
1. Альтернатива (без pipe) команде `grep <some_string> <some_file> | wc -l` команда:
   * `grep <some_string> <some_file> -c`
     
   Ознакомился с [http://www.smallo.ruhr.de/award.html](http://www.smallo.ruhr.de/award.html).
1. Процесс `systemd` с PID `1` является родителем для всех процессов
1. Команда, перенаправления вывод stderr `ls` на другую сессию терминала:
   * `ls -errorgen 2> /dev/pts/1`
1. Передаём команде `cat` файл `ls1.txt`на stdin и выводим через ее stdout в файл `ls2.txt`
   * `cat < ls1.txt > ls2.txt`
1. Получатся вывести находясь в графическом режиме данные из PTY в эмулятор TTY (Например в **TTY2**). Выводимые данные могу наблюдать только на stdout **TTY2**.
   * Например `ls -la > /dev/tty2`
1. Выполнил команду `bash 5>&1`. Привела к созданию файлового дескриптора `5` (с доступом на чтение и запись) и перенаправлению в `stdout`
   После выполнения `echo netology > /proc/$$/fd/5` произойдёт перенаправление в дескриптор `5` c последующим вывод в `stdout`
1. Поменяли стандартные потоки местами через промежуточный новый дескриптор `5`.
   * `ls -errorgen 5>&2 2>&1 1>&5 | grep inv`
1. Команда `cat /proc/$$/environ` выводит переменные окружения. Human readable: `sed -z 's/$/\n/' /proc/$$/environ` Для получения аналогичного по содержанию вывода:
   * `printenv`
1. * По адресу `/proc/<PID>/cmdline` находится файл (только для чтения) содержащий командный путь процесса, если только процесс не "зомби". Строка **211**
   * По адресу `/proc/<PID>/exe` находится файл (символическая ссылка) содержащий имя пути исполняемой команды. Строка **261**
1. Самая старшая версия набора инструкций SSE поддерживаемая моим процессором `*SSE4a*`.
1. Вывод `not a tty` при исполнении команды `ssh localhost 'tty'`, команда не запускается внутри терминала (не выделяется **pts**), для решения необходимо указать аттрибут `-t`:
   
   ``ssh -t localhost 'tty'``

1. Установил **reptyr**. Попробовал переместить запущенный процесс из одной сессии в другую `reptyr`. В первой сессии выполнился останов программы. На второй `reptyr` выдал ошибку:  
   ```Unable to attach to pid 3819: Operation not permitted
   The kernel denied permission while attaching. If your uid matches
   the target's, check the value of /proc/sys/kernel/yama/ptrace_scope.
   For more information, see /etc/sysctl.d/10-ptrace.conf
   ```
1. Команда `tee` считывает из **stdin** и пишет в **stdout** и файлы. Конструкция `echo string | sudo tee /root/new_file` передаст через конвейер на stdin `tee` (запущенной с правами su) строку и соответственно произведёт запись в файл (так как права на запись в `/root` будут)
