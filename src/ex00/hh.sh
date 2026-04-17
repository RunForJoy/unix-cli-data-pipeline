#!/bin/bash

# --- Настройки ---
SEARCH_QUERY="${@:-data scientist}" # Аргумент по умолчанию
PER_PAGE=20

# --- Подготовка запроса ---
ENCODED_QUERY=$(printf '%s' "$SEARCH_QUERY" | jq -sRr @uri)
URL="https://api.hh.ru/vacancies?text=${ENCODED_QUERY}&per_page=${PER_PAGE}"

echo "🔍 Запрашиваемый URL: $URL"
echo "---"

# --- Выполнение запроса ---
# Используем стандартный набор заголовков (он уже достаточно хорош)
curl -sL -A "Mozilla/5.0" "$URL" | jq . > hh.json

# --- Обработка результата ---
# Проверяем, был ли файл создан и не пустой ли он
if [ -s "hh.json" ]; then

    # Проверяем на наличие ошибки 'forbidden' на случай, если заголовки не помогли
    if grep -q '"type":"forbidden"' hh.json; then
        echo "❌ Ошибка доступа (403 Forbidden). Защита HeadHunter блокирует запрос."
        echo "   Попробуйте обновить скрипт или использовать VPN."
        exit 1
    fi

    # Извлекаем количество найденных вакансий. Используем // empty, чтобы jq не выводил ничего, если поля нет.
    FOUND_COUNT=$(jq '.found // empty' hh.json)
    
    echo "✅ Данные для вакансии '$SEARCH_QUERY' сохранены в hh.json"
    echo "📄 Всего найдено: ${FOUND_COUNT:-0} вакансий."

    # Проверяем, есть ли сами вакансии в массиве items и выводим их красиво
    if [ "$FOUND_COUNT" -gt 0 ]; then
        echo "📋 Список первых ${PER_PAGE} вакансий:"
        jq -r '.items[] | "$.name) | $.employer.name) | Ссылка: https://hh.ru$.alternate_url)"' hh.json | head -n $PER_PAGE
    else
        echo "👍 По вашему запросу вакансий не найдено. Попробуйте изменить ключевые слова."
    fi

else
    echo "🛑 Ошибка: Не удалось получить данные от сервера. Проверьте интернет-соединение."
fi