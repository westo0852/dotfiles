#!/bin/bash
# Used for status bar in ~/.config/sway/config

identity="$USER@$HOSTNAME"

mem_total_kb=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
mem_avail_kb=$(awk '/MemAvailable:/ {print $2}' /proc/meminfo)
mem_used_kb=$((mem_total_kb - mem_avail_kb))

ram_pct=$((mem_used_kb * 100 / mem_total_kb))
ram_used=$(numfmt --to=iec $((mem_used_kb * 1024)))
ram_total=$(numfmt --to=iec $((mem_total_kb * 1024)))

# Service set identifier: wireless network name
ssid=$(command -v iwgetid &>/dev/null && iwgetid -r || echo "unknown")
[[ -n "$ssid" ]] || ssid="?"
ipv4=$(ip addr show wlan0 2>/dev/null | rg "inet " | awk '{print $2}' | cut -d"/" -f1)
[[ -n "$ipv4" ]] && wifi_status="Connected to $ssid ($ipv4)" || wifi_status="Not connected"

# received=$(cat /sys/class/net/wlan0/statistics/rx_bytes | numfmt --to=iec-i)
# transmitted=$(cat /sys/class/net/wlan0/statistics/tx_bytes | numfmt --to=iec-i)

capacity="$(cat /sys/class/power_supply/BAT1/capacity)"
status="$(cat /sys/class/power_supply/BAT1/status)"

brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)
light=$(awk "BEGIN {print $brightness / $max_brightness * 100}")

volume=$(amixer sget Master | awk -F"[][]" '/Left:/ {print $2}')

datetime=$(date "+%A %+4Y-%m-%d %H:%M")

entries=(
  # "CPU: $cpu%"
  "RAM: ${ram_used}/${ram_total} (${ram_pct}%)"
  # "$received down, $transmitted up"
  "Volume: $volume"
  "Light: $light%"
  "Power: $capacity% ($status)"
  "$wifi_status"
  "$identity"
  "$datetime"
)

delimiter=" · "
statusbar="${entries[0]}"
for e in "${entries[@]:1}"; do statusbar+="$delimiter$e"; done

echo "$statusbar"

notif_shown="/tmp/swaybar_battery_low"

if [ "$capacity" -le 15 ] && [ "$status" != "Charging" ]; then
  if [ ! -f "$notif_shown" ]; then
    notify-send --urgency=CRITICAL "Battery low! Pls charge"
    touch "$notif_shown"
  fi
else
  rm -f "$notif_shown"
fi
