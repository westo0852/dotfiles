#!/bin/bash

# Used for status bar in ~/.config/sway/config

identity="$USER@$HOSTNAME"

cpu="$(top -bn2 -d 1 | grep "Cpu(s)" | tail -1 | awk '{print 100 - $8}')"

ssid=$(command -v iwgetid &>/dev/null && iwgetid -r || "unknown")
ipv4=$(ip addr show wlan0 | rg "inet " | awk '{print $2}' | cut -d"/" -f1)

received=$(cat /sys/class/net/wlan0/statistics/rx_bytes | numfmt --to=iec-i)
transmitted=$(cat /sys/class/net/wlan0/statistics/tx_bytes | numfmt --to=iec-i)

capacity="$(cat /sys/class/power_supply/BAT1/capacity)"
status="$(cat /sys/class/power_supply/BAT1/status)"

brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)
light=$(awk "BEGIN {print $brightness / $max_brightness * 100}")

volume=$(amixer sget Master | awk -F"[][]" '/Left:/ {print $2}')

datetime=$(date "+%A %+4Y-%m-%d %H:%M")

entries=(
  # "CPU: $cpu%"
  "Volume: $volume"
  "Light: $light%"
  "Power: $capacity% ($status)"
  # "WiFi: $ssid" ($ipv4)
  "$ssid"
  # "$received down, $transmitted up"
  "$identity"
  "$datetime"
)

delimiter=" · "
statusbar="${entries[0]}"
for e in "${entries[@]:1}"; do statusbar+="$delimiter$e"; done
echo "$statusbar"
