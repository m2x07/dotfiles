#!/usr/bin/env bash

BAT_PATH="/sys/class/power_supply/BAT0"
CAPACITY=$(cat "$BAT_PATH/capacity")
STATUS=$(cat "$BAT_PATH/status")

if [ "$STATUS" == "Discharging" ] && [ "$CAPACITY" -le 20 ]; then
    notify-send -a "battery_notify.sh" -u normal "Low battery warning!" "Only ${CAPACITY}% remaining"
elif [ "$STATUS" == "Discharging" ] && [ "$CAPACITY" -le 10 ]; then
    notify-send -a "battery_notify.sh" -u critical "Battery level critical: ${CAPACITY}%" "Plug in a power source now"
elif [ "$STATUS" == "Charging" ] && [ "$CAPACITY" -gt 97 ]; then
    notify-send -a "battery_notify.sh" -u normal "Fully charged" "You may now unplug the charger"
fi
