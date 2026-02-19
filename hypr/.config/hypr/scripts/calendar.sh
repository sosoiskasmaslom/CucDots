#!/bin/bash
# Скрипт для календаря который не исчезает при наведении
# Сохрани как ~/.config/waybar/scripts/calendar.sh и сделай исполняемым: chmod +x ~/.config/waybar/scripts/calendar.sh

# Путь к файлу-флагу
FLAG="/tmp/waybar_calendar_visible"

if [ -f "$FLAG" ]; then
    # Календарь уже показан - скрываем
    rm "$FLAG"
    pkill -f "yad.*calendar" 2>/dev/null
else
    # Показываем календарь
    touch "$FLAG"
    
    # Получаем позицию курсора
    eval "$(xdotool getmouselocation --shell)"
    
    # Показываем yad календарь
    yad --calendar \
        --undecorated \
        --fixed \
        --close-on-unfocus \
        --no-buttons \
        --width=220 \
        --height=200 \
        --posx=$((X - 110)) \
        --posy=$((Y + 20)) \
        --title="Calendar" \
        2>/dev/null
    
    # После закрытия удаляем флаг
    rm "$FLAG" 2>/dev/null
fi
