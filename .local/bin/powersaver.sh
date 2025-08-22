#!/usr/bin/env bash

LOCKFILE="/tmp/powersaverlock"

toggle_on() {
    echo "Reducing screen refresh rate and brightness..."
    hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1 &>/dev/null
    brightnessctl set 20% &>/dev/null

    echo "Disabling hyprland animations..."
    hyprctl keyword animations:enabled 0 &>/dev/null

    echo "Changing power-profile-daemon to power-saver profile..."
    powerprofilesctl set power-saver &>/dev/null

    echo "true" > "$LOCKFILE"
    echo "Lockfile '"$LOCKFILE"' written"
}
toggle_off() {
    echo "Power saving settings already enabled. Turning off"
    echo "Resetting hyprland settings..."
    hyprctl reload &>/dev/null

    echo "Setting brightness to 30%"
    brightnessctl set 30% &>/dev/null
    
    echo "Changing power-profile-daemon to balanced profile..."
    powerprofilesctl set balanced &>/dev/null

    rm "$LOCKFILE"
    echo "Lockfile removed"
}

if [ -f "$LOCKFILE" ]; then
    toggle_off
else
    toggle_on
fi
