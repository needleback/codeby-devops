#!/bin/bash

MYFOLDER=/home/${USER}/myfolder

cd ${MYFOLDER}/

# Определяет, как много файлов создано в папке myfolder
#count_files=$(ls -l | grep '^-' | wc -l)
#echo "total files: ${count_files}"

# Исправляет права второго файла с 777 на 664
if [ -e file2 ]; then
  chmod 664 file2
fi

count_files=0
for ifile in $(ls -1); do
  if [ -f "$ifile" ]; then
    # Определяет как много файлов создано в папке myfolder
    ((count_files++))
    file_size=$(wc -c < "$ifile")
    if [ $file_size -lt 1 ]; then
      # Определяет пустые файлы и удаляет их
      rm -f "$ifile"
    else
      # Удаляет все строки кроме первой в остальных файлах
      sed -i '2,$d' "$ifile"
    fi
  fi
done

# Выводит как много файлов создано в папке myfolder
echo "total files: ${count_files}"
