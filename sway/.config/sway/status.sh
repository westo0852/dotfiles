#!/bin/bash

# Used for status bar in ~/.config/sway/config

cpu="$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')"

# TODO Add memory disk network etc

capacity="$(cat /sys/class/power_supply/BAT1/capacity)"
status="$(cat /sys/class/power_supply/BAT1/status)"

brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)
light=$(awk "BEGIN {print $brightness / $max_brightness * 100}")

datetime=$(date "+%a %d-%m-%+4Y %T")

echo "CPU: $cpu% | Power: $capacity% ($status) | Light: $light% | $datetime"
