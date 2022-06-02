#!/bin/bash

set -x
echo "start"
echo connect to $IP 

OVOL=20

checkconnect(){
        CONNECT=0
        while [ $CONNECT -lt 2 ];
        do
                echo $CONNECT
                adb connect $IP
                CONNECT=$(adb devices | grep device -c )
                sleep 30
        done
        checkvol
}

checkvol(){
        while :
        do
                VOL=$(adb shell media volume --get | grep  -E -o "is (\w+)" | awk '{print $2}')
                if [ -n "$(echo $VOL| sed -n "/^[0-9]\+$/p")" ]; then
                        DIFVOL=`expr $VOL - $OVOL`
                        OVOL=$VOL
                        echo VOL:$VOL DIFVOL:$DIFVOL
                else
                        echo disconnect
                        adb disconnect
                        break                
                fi

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


