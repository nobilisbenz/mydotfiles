#!/usr/bin/env sh

LAN=$(hyprctl devices -j 2>/dev/null | jq -r '.keyboards[0].layout' || echo "EN")

VOL=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -oP '\d+(?=%)' | head -1 || echo "0")
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | grep -q "yes" && echo "1" || echo "0")
if [ "$MUTED" = "1" ]; then
    VOL_DISPLAY="MUTE"
else
    VOL_DISPLAY="VOL ${VOL}%"
fi

NET=$(nmcli -t -f ACTIVE,NAME dev wifi | grep "^yes" | head -1 | cut -d: -f2)
if [ -z "$NET" ]; then
    NET="OFF"
fi

MEM=$(free -m | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d% -f1)

BAT=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "100")
CHG=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null | grep -i "charging\|full" && echo "1" || echo "0")
if [ "$CHG" = "1" ]; then
    BAT_DISPLAY="AC ${BAT}%"
else
    BAT_DISPLAY="BAT ${BAT}%"
fi

echo "$LAN  $VOL_DISPLAY  $NET  RAM ${MEM}%  CPU ${CPU}%  $BAT_DISPLAY"
