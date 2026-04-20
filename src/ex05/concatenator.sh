#!/bin/bash

# 1. Определяем список всех файлов с датами
FILES=$(ls [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].csv 2>/dev/null)

# Проверяем, нашли ли мы что-нибудь
if [ -z "$FILES" ]; then
    echo "Нет файлов для объединения"
    exit 1
fi

# 2. Берем первый файл из списка, чтобы вытащить заголовок
FIRST_FILE=$(echo "$FILES" | head -n 1)
head -n 1 "$FIRST_FILE" > hh_positions.csv

# 3. Добавляем данные из всех найденных файлов
for f in $FILES; do
    tail -n +2 "$f" >> hh_positions.csv
done

echo "Все файлы объединены в hh_positions.csv"
