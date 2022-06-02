#!/bin/bash

echo "start"
echo connect to $IP 

CONNECT=$(adb devices | grep "$IP" -c )

OVOL = 20

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
        DIFVOL=`expr $VOL - $OVOL`
        if [ $DIFVOL -gt 2]; then
                echo too fast
                adb shell media volume --show --set 0
        fi
        if [ $VOL -gt 20 ]; then
                echo to larg
                adb shell media volume --show --set 0
        fi
done
