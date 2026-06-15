#!/bin/bash

ACTION=$1  # "open" или "close"

# Проверяем, подключён ли внешний монитор
EXTERNAL=$(hyprctl monitors -j | jq '[.[] | select(.name != "eDP-1")] | length')

if [ "$EXTERNAL" -gt 0 ]; then
    if [ "$ACTION" = "close" ]; then
        hyprctl keyword monitor "eDP-1,disable"
    else
        hyprctl keyword monitor "eDP-1,1920x1200@60,0x0,1"
    fi
else
    if [ "$ACTION" = "close" ]; then
        $HOME/.local/share/quickshell-lockscreen/lock.sh
    fi
fi
