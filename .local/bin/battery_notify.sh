#!/usr/bin/env bash

BAT_PATH="/sys/class/power_supply/BAT0"
CAPACITY=$(cat "$BAT_PATH/capacity")
STATUS=$(cat "$BAT_PATH/status")
FLAGFILE=/tmp/batterynotificationsent

if [ "$STATUS" == "Discharging" ]; then
    if [ "$CAPACITY" -gt 20 ]; then
        if [ -e $FLAGFILE ]; then
            rm $FLAGFILE
        fi
    elif [ "$CAPACITY" -le 10 ]; then
        notify-send -a "battery_notify.sh" -u critical "Battery level critical: ${CAPACITY}%" "Plug in a power source now"
    elif [ "$CAPACITY" -le 20 ]; then
        if [ ! -e $FLAGFILE ]; then
            notify-send -a "battery_notify.sh" -u normal "Low battery warning!" "Only ${CAPACITY}% remaining"
            touch $FLAGFILE
        fi
    fi
else
    if [ "$CAPACITY" -ge 85 ]; then
        if [ ! -e $FLAGFILE ]; then
            notify-send -a "battery_notify.sh" -u normal "Battery fully charged" "You may now unplug the charger"
            touch $FLAGFILE
        fi
    else
        if [ -e $FLAGFILE ]; then
            rm $FLAGFILE
        fi
    fi
fi
