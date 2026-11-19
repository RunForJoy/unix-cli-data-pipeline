#!/bin/sh
echo "\"id\",\"created_at\",\"name\",\"has_test\",\"alternate_url\"" > hh_positions.csv
tail -n +2 ../ex02/hh_sorted.csv | \
sed 's/","/;/g' | \
sed 's/^"//;s/"$//' | \
while IFS=';' read -r id created_at name has_test alternate_url; do
pos=$(echo "$name" | grep -oE 'Junior|Middle|Senior' | tr '\n' '/')
pos=$(echo "$pos" | sed 's/\/$//')
[ -z "$pos" ] && pos="-"
echo "\"$id\",\"$created_at\",\"$pos\",\"$has_test\",\"$alternate_url\""
done >> hh_positions.csv