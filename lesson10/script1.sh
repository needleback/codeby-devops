#!/bin/bash

MYFOLDER=/home/${USER}/myfolder

rm -r ${MYFOLDER}/

# Создает папку myfolder в домашней папке текущего пользователя
mkdir ${MYFOLDER}/

# имеет две строки: 1) приветствие, 2) текущее время и дата
touch ${MYFOLDER}/file1
echo 'Hello world' > ${MYFOLDER}/file1
echo $(date) >> ${MYFOLDER}/file1

# пустой файл с правами 777
touch ${MYFOLDER}/file2
chmod 777 ${MYFOLDER}/file2

# одна строка длиной в 20 случайных символов
touch ${MYFOLDER}/file3
echo $( head -c 30 /dev/urandom | base64 | tr -dc 'A-Za-z' | head -c 20; echo ) > ${MYFOLDER}/file3

# пустые файлы
touch ${MYFOLDER}/file{4..5}
