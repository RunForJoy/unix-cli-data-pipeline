#!/bin/sh

INPUT_FILE="../ex01/hh.csv"
OUTPUT_FILE="hh_sorted.csv"

if [ ! -f "$INPUT_FILE" ]; then
  echo "Ошибка: файл $INPUT_FILE не найден."
  exit 1
fi

if head -n 1 "$INPUT_FILE" > "$OUTPUT_FILE" && \
   tail -n +2 "$INPUT_FILE" | sort -t ',' -k 2,2 -k 1,1n >> "$OUTPUT_FILE"; then
   echo "Файл $OUTPUT_FILE успешно создан"
else
  echo "Файл не был создан."
fi
