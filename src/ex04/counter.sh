#!/bin/sh

echo '"name","count"' > hh_uniq_positions.csv
cut -d',' -f3 ../ex03/hh_positions.csv | tail -n +2 | sort | uniq -c | sort -k1,1rn -k2,2 | awk '{print $2 "," $1}' >> hh_uniq_positions.csv
#cut -d',' -f3 ../ex03/hh_positions.csv | tail -n +2 | sort | uniq -c | awk '{print $2 "," $1}' | sort -t',' -k2,2rn -k1,1 >> hh_uniq_positions
echo "Файл hh_uniq_positions.csv успешно создан"

