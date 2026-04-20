#!/bin/sh

INPUT_FILE="../ex02/hh_sorted.csv"
OUTPUT_FILE="hh_positions.csv"

if [ ! -f "$INPUT_FILE" ]; then
  echo "Ошибка: файл $INPUT_FILE не найден."
  exit 1
fi

awk '
BEGIN {
    OFS=","
    FPAT = "([^,]+)|(\"[^\"]+\")"
}
{
    if (NR == 1) {
        print $0
        next
    }

    name_field = $3
    gsub(/^"|"$/, "", name_field)
    result = ""
    n = split(name_field, words, "[ /]+")

    for (i = 1; i <= n; i++) {
        word = words[i]
        gsub(/[,.;:!?()]+$/, "", word)

        if (word == "Junior" || word == "Middle" || word == "Senior") {
            if (result == "") {
                result = word
            } else if (index(result, word) == 0) {
                result = result "/" word
            }
        }
    }

    if (result == "") {
        result = "-"
    }

    print $1, $2, "\"" result "\"", $4, $5
}
' "$INPUT_FILE" > "$OUTPUT_FILE"

echo "Обработка завершена. Результат сохранён в $OUTPUT_FILE"

# блок BEGIN в awk выполняется ровно один раз в самом начале, 
# до того, как программа начнет читать строки из файла.
# OFS="," устанавливает разделитель полей для вывода (Output Field Separator)
# использую FPAT- Field PATtern вместо разделителя -F ',' который просто режет строку 
# по запятым и ломался на  столбце "Middle Data Scientist (ML, Python)"
# FPAT: либо текст без запятых, либо текст в кавычках (внутри него кавычек нет)
# NR - Number of Records, печатаем шапку
# gsub убираем кавычки вначале и конце переменной name_field
# split разбиваем значение столбца name на части по пробелам и /, сохраняем их в массив words, 
# а количество полученных элементов — в переменную n
# index выдает позицию подстроки (word) в строке result начиная с 1 или 0 если подстроки нет 