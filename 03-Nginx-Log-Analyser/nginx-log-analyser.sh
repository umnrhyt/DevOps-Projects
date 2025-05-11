#!/bin/bash
COUNTS=5


echo -e "\nTop ${COUNTS} IP addresses with the most requests:"
awk '{print $1}' nginx-access.log | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${COUNTS}

echo -e "\nTop ${COUNTS} most requested paths:"
awk '{print $7}' nginx-access.log | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -n ${COUNTS}

echo -e "\nTop ${COUNTS} response status codes:"
grep -oE ' [1-5][0-9]{2} ' nginx-access.log | sort | uniq -c | sort -rn | awk '{print $2 " - " $1 " requests"}' |  head -n $COUNTS 

echo -e "\nTop ${COUNTS} user agents:"
awk -F'"' '{print $6}' nginx-access.log | sort | uniq -c | sort -nr | awk '{for(i=2;i<=NF;i++) printf "%s ", $i; print "-",$1,"requests"}' | head -n $COUNTS
