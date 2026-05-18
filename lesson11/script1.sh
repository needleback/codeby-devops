#!/bin/bash


#********************************#
#    script1.sh                  #
#    lesson11                    #
#                                #
#    автор: needleback           #
#    май 2026                    #
#    Рефакторинг bash-сценария.  #
#********************************#


# Рабочая папка myfolder в домашней папке текущего пользователя
MYFOLDER=${HOME}/myfolder

# Проверяю существует ли рабочая папка
if [ -d ${MYFOLDER} ]; then
  # если существует, то удаляю
  echo "Папка ${MYFOLDER} уже существует, Удаляю ее"
  rm -r ${MYFOLDER}/
fi

# Создаю рабочую папку
mkdir ${MYFOLDER}/

# создаю файл
touch ${MYFOLDER}/file1
# добавляю в файл с перезаписью: 1) приветствие
echo 'Hello world' > ${MYFOLDER}/file1
# добавляю в файл: 2) текущее время и дата
echo $(date) >> ${MYFOLDER}/file1

# создаю пустой файл
touch ${MYFOLDER}/file2
# изменяю права нового файла на 777
chmod 777 ${MYFOLDER}/file2

#  создаю пустой файл
touch ${MYFOLDER}/file3
# добавляю в новый файл одну строку длиной в 20 случайных символов
echo $( head -c 30 /dev/urandom | base64 | tr -dc 'A-Za-z' | head -c 20; echo ) > ${MYFOLDER}/file3

# создаю 2 пустых файла
touch ${MYFOLDER}/file{4..5}

# завершаю скрипт
echo "${0} completed successfully"
