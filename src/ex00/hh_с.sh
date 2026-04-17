#!/bin/bash

vacancy_name="$1"

if [ -z "$vacancy_name" ]; then
    vacancy_name="data scientist"
fi

encoded_vacancy=$(printf '%s' "$vacancy_name" | jq -sRr @uri)
url="https://api.hh.ru/vacancies?text=${encoded_vacancy}&per_page=20"

# Полный набор заголовков как у браузера
curl -s \
     -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
     -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8" \
     -H "Accept-Language: ru-RU,ru;q=0.8,en-US;q=0.5,en;q=0.3" \
     -H "Accept-Encoding: gzip, deflate, br" \
     -H "Connection: keep-alive" \
     -H "Upgrade-Insecure-Requests: 1" \
     -H "Sec-Fetch-Dest: document" \
     -H "Sec-Fetch-Mode: navigate" \
     -H "Sec-Fetch-Site: none" \
     -H "Sec-Fetch-User: ?1" \
     -H "Cache-Control: max-age=0" \
     --compressed \
     "$url" | jq '.' > hh.json