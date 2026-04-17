#!/bin/bash

SEARCH_QUERY="$1"
RESULT_FILE="hh.json"

if [ $# -ne 1 ]; then
    echo "Usage: $0 'data scientist'"
    exit 1
fi

query=$(echo "$SEARCH_QUERY" | jq -sRr @uri)

# Мобильный User-Agent
MOBILE_UA="Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1"

# Другой эндпоинт API
curl -s \
    -H "User-Agent: $MOBILE_UA" \
    -H "Accept: application/json" \
    -H "X-Requested-With: XMLHttpRequest" \
    "https://hh.ru/vacancies/search?text=${query}&per_page=20" | \
    jq '.' > "$RESULT_FILE"

if [ -s "$RESULT_FILE" ] && ! grep -q "forbidden" "$RESULT_FILE"; then
    echo "✅ Сохранено в $RESULT_FILE"
else
    echo "❌ Не работает, IP заблокирован окончательно"
    echo "Единственный выход: сменить IP через VPN или другой интернет"
fi