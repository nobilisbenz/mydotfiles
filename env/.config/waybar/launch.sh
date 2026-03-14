#!/bin/bash
killall -q waybar
while pgrep -u $UID -x waybar >/dev/null; do sleep 1; done
waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css 2>&1 | tee -a /tmp/waybar.log & disown
