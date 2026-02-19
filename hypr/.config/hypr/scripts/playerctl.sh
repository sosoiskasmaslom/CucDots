#!/bin/bash
# Playerctl с автообновлением в реальном времени
# Сохрани как ~/.config/waybar/scripts/playerctl-live.sh

# Приоритетные плееры
PRIORITY_PLAYERS=("elisa" "org.mpris.MediaPlayer2.elisa" "spotify" "firefox")
NO_MUSIC_TEXT="No music"

# Функция вывода данных
output_data() {
    local text="$1"
    local status="$2"
    local class="${status,,}"  # lowercase
    
    if [ -z "$status" ]; then
        class="stopped"
        status="stopped"
    fi
    
    echo "{\"text\": \"$text\", \"class\": \"$class\", \"alt\": \"$status\"}"
}

# Функция получения предпочитаемого плеера
get_preferred_player() {
    local available=$(playerctl -l 2>/dev/null)
    
    if [ -z "$available" ]; then
        echo ""
        return
    fi
    
    # Проверяем по приоритету
    for player in "${PRIORITY_PLAYERS[@]}"; do
        if echo "$available" | grep -q "^${player}$"; then
            echo "$player"
            return
        fi
    done
    
    # Возвращаем первый доступный
    echo "$available" | head -n1
}

# Основной цикл с подпиской на изменения
playerctl -F metadata --format '{{artist}}|||{{title}}' 2>/dev/null | while IFS='|||' read -r player status artist title; do
    # Если нет данных - проверяем есть ли плееры вообще
    if [ -z "$player" ]; then
        preferred=$(get_preferred_player)
        if [ -z "$preferred" ]; then
            output_data "$NO_MUSIC_TEXT" "stopped"
            continue
        fi
    fi
    
    # Формируем текст
    if [ -n "$title" ] && [ "$title" != "No players found" ]; then
        if [ -n "$artist" ] && [ "$artist" != "Unknown" ]; then
            text="$artist - $title"
        else
            text="$title"
        fi
        output_data "$text" "$status"
    else
        output_data "$NO_MUSIC_TEXT" "stopped"
    fi
done

# Если playerctl завершился (нет плееров при старте)
output_data "$NO_MUSIC_TEXT" "stopped"
