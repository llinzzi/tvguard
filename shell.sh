#!/bin/bash

echo "start"
echo connect to $IP 

CONNECT=$(adb devices | grep "$IP" -c )

OVOL=20

checkconnect(){
        while [ $CONNECT -lt 1 ];
        do
                sleep 30
                echo $CONNECT
                adb connect $IP
                CONNECT=$(adb devices | grep $IP -c )
        done
        checkvol
}

checkvol(){
        while :
        do
                VOL=$(adb shell media volume --get | grep  -E -o "is (\w+)" | awk '{print $2}')
                if [ $? -ne 0 ]; then
                        adb disconnect
                        echo disconnect
                        break
                fi
                DIFVOL=`expr $VOL - $OVOL`
                OVOL=$VOL
                echo VOL:$VOL DIFVOL:$DIFVOL
                if [ $DIFVOL -gt 2 ]; then
                        echo too fast
                        adb shell media volume --show --set 0
                fi
                if [ $VOL -gt 20 ]; then
                        echo to larg
                        adb shell media volume --show --set 0
                fi
        done
        checkconnect
}

checkconnect


