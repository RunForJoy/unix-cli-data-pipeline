#!/bin/bash

# 1. Берем название вакансии из первого аргумента
# Если аргумента нет, используем "data scientist"
QUERY="${1:-data scientist}"

# 2. Кодируем пробелы для URL (заменяем на %20)
# Это самый совместимый способ для Mac и Linux
ENCODED_QUERY=$(echo "$QUERY" | sed 's/ /%20/g')

# 3. Делаем запрос к API и форматируем через jq
# -s убирает мусор из консоли, -H добавляет обязательный User-Agent
curl -s -H "User-Agent: MyProject/1.0" \
     "https://hh.ru{ENCODED_QUERY}&per_page=20" | jq . > hh.json

echo "Загрузка завершена для: $QUERY"
