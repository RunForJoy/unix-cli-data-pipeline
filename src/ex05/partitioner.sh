#!/bin/bash

INPUT_FILE="../ex03/hh_positions.csv"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Ошибка: Файл $INPUT_FILE не найден."
    exit 1
fi

awk -F',' '
    NR == 1 { 
        header = $0; 
        next; 
    } 
    {
        # Вырезаем дату YYYY-MM-DD из кавычек во втором столбце
        filename = substr($2, 2, 10) ".csv";

        # Если файл встречается впервые, записываем в него шапку
        if (!(filename in seen)) {
            print header > filename;
            seen[filename] = 1;
        }
        # Дописываем строку данных
        print $0 >> filename;
    }' "$INPUT_FILE"

echo "Созданные файлы:"
ls 2026-*.csv
