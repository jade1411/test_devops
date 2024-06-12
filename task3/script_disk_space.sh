#!/bin/bash

time=$(date +%Y-%m-%d-%H:%M:%S)
limit=85

while read -r line; do
    device=$(echo $line | awk '{print $1}')
    space=$(echo $line | awk '{print $5}' | tr -d '%')

    if [ $space -gt $limit ]; then
        size=$(df -h $device | awk 'NR==2{print $4}')
        subject="Disk Space Alert"
        message="Warning! Disk Space on $device is almost full. Available: $size."

        echo -e "Subject: $subject\n\n$time\n$message" | ssmtp eprikul1703@gmail.com
    fi
done < <(df)
