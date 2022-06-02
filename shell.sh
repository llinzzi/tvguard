#!/bin/bash

echo "start"
echo connect to $IP

CONNECT=$(adb devices | grep "$IP" -c )

while [ $CONNECT -lt 1 ];
do
        sleep 30
        echo $CONNECT
        adb connect $IP
        CONNECT=$(adb devices | grep $IP -c )
done

while :
do
        VOL=$(adb shell media volume --get | grep  -E -o "is (\w+)" | awk '{print $2}')
        echo VOL:$VOL
        if [ $VOL -gt 20 ]; then
                echo nonono
                adb shell media volume --set 0
        fi
done
