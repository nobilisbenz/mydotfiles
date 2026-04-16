#!/usr/bin/env sh

main() {
    WS=$(hyprctl workspaces -j 2>/dev/null | jq -r '.[] | select(.windows > 0) | .id' | sort -n | paste -sd ' ' -)
    echo " $WS"
}

main
