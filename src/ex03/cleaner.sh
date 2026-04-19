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
    # -F, не работает с CSV так как ломает строки с запятыми внутри кавычек
    # Field PATtern как выглядит поле, то есть либо текст без запятых, либо текст в кавычках (внутри него кавычек нет)
    FPAT = "([^,]+)|(\"[^\"]+\")"
}
{
# Number of Records - первую строку без изменений
    if (NR == 1) {
        print $0
        next
    }

    name_field = $3
    # убираем кавычки вначале и конце
    gsub(/^"|"$/, "", name_field)

    result = ""

    # разбиваем значение столбца name на части по пробелам и /, сохраняем их в массив words, а количество полученных элементов — в переменную n.
    n = split(name_field, words, "[ /]+")

    for (i = 1; i <= n; i++) {
        word = words[i]
        gsub(/[,.;:!?()]+$/, "", word)

        if (word == "Junior" || word == "Middle" || word == "Senior") {
            if (result == "") {
                result = word
            # index выдает позицию подстроки (word) в строке result начиная с 1 или 0 если подстроки нет 
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