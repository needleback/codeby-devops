#!/bin/bash

#********************************#
#    script2.sh                  #
#    lesson11                    #
#                                #
#    автор: needleback           #
#    май 2026                    #
#    Рефакторинг bash-сценария.  #
#********************************#


# Рабочая папка myfolder в домашней папке текущего пользователя
MYFOLDER=${HOME}/myfolder
# код возврата, если файл или папка не найдены
E_NOTFOUND=75

# проверяю существует ли рабочая папка
if [ ! -d ${MYFOLDER} ]; then
  # если папка не существует, то завершаю скрипт
  echo "The directory ${MYFOLDER} has not been created yet"
  exit $E_NOTFOUND
fi

# перехожу в рабочую папку
cd ${MYFOLDER}/

# альтернативное решение подсчета созданных файлов в папке
# Определяет, как много файлов создано в папке myfolder
#count_files=$(ls -l | grep '^-' | wc -l)
#echo "total files: ${count_files}"

# Исправляет права второго файла с 777 на 664
if [ -e file2 ]; then
  # если файл существует
  chmod 664 file2
fi

# счетчик количества файлов
count_files=0
for ifile in $(ls); do
  # цикл по всем файлам
  if [ -f "$ifile" ]; then
    # Определяет как много файлов создано в папке myfolder
    ((count_files++))
    # считаю размер файла
    file_size=$(wc -c < "$ifile")
    if [ $file_size -lt 1 ]; then
      # если размер файла меньше 1, то удаляю файл
      rm -f "$ifile"
    else
      # иначе, удаляю все строки кроме первой в остальных файлах
      sed -i '2,$d' "$ifile"
    fi
  fi
done

# Выводит как много файлов создано в папке myfolder
echo "total files: ${count_files}"

# завершаю скрипт
echo "${0} completed successfully"
