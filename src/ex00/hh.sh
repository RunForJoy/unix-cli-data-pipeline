# https://api.hh.ru/openapi/redoc#section/Avtorizaciya
# https://api.hh.ru/openapi/redoc
# https://dev.hh.ru/admin  - здесь зарегила приложение

#!/bin/bash

if [ "$#" -eq 1 ]; then
    query="${1// /+}"
    
    CLIENT_ID="L65ER0JCQ4CDQDJ9P64EGAP7OSC2VF0J2EN8R5ATMM81JPO5L4FR2741L4C2MBGK"
    CLIENT_SECRET="RVTJMUDBTRLC1DM99LQ9E57OT2NKI7A4U7VVNN91F2TV1QF4RF0U7AITT96I7UEH"
    USER_AGENT="DataScienceLearning/1.0 (runforjoy.psn@gmail.com; Linux x86_64)"
    
    # получение access_token
    TOKEN_RESPONSE=$(curl -s -X POST https://hh.ru/oauth/token \
        -H "User-Agent: $USER_AGENT" \
        -d "grant_type=client_credentials" \
        -d "client_id=$CLIENT_ID" \
        -d "client_secret=$CLIENT_SECRET")
    
    # извлечение токена из ответа
    ACCESS_TOKEN=$(echo "$TOKEN_RESPONSE" | jq -r '.access_token')
    
    # проверка, что токен получен
    if [ "$ACCESS_TOKEN" = "null" ] || [ -z "$ACCESS_TOKEN" ]; then
        echo "Не удалось получить токен:"
        echo "$TOKEN_RESPONSE" | jq '.'
        exit 1
    fi
    
    #  запрос к API с токеном
    curl -s \
        -H "User-Agent: $USER_AGENT" \
        -H "Authorization: Bearer $ACCESS_TOKEN" \
        -H "Accept: application/json" \
        "https://api.hh.ru/vacancies/?text=$query&search_field=name&per_page=20" \
        | jq '.' > hh.json
    
    echo "Результат сохранён в hh.json"
else
    echo "Для исполнения скрипта необходимо передать аргумент. Пример: ./hh.sh 'data scientist'"
    exit 1
fi