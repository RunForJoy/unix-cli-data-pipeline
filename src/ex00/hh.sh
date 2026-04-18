#!/bin/bash

if [ "$#" -eq 1 ]; then ## если передан ровно один аргумент
    query="${1// /+}" ## пробелы в первом арг-те заменить на +
    # curl это HTTP-запрос, -s → silent, text=$query → поисковый запрос
    # search_field=name → искать по названию вакансии
    # jq '.' → просто форматирует JSON (pretty print)
    curl -s "https://api.hh.ru/vacancies/?text=$query&search_field=name&per_page=20" \
        | jq '.' > hh.json
else
    echo "для исполнения скрипта необходимо передать аргумент. Пример: ./hh.sh 'data scientist'"
fi