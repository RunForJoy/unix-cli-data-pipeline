#!/bin/sh

if [ ! -f "../ex00/hh.json" ]; then #  !-f если файл не сущ-т
  echo "Ошибка: файл hh.json не найден в ../ex00/"
  exit 1
fi

jq -r -f filter.jq ../ex00/hh.json > hh.csv # Запускаем фильтрацию

if [ $? -eq 0 ]; then # Проверяем успешность выполнения
  echo "Файл CSV успешно создан."
else
  echo "Файл не был создан."
  exit 1
fi