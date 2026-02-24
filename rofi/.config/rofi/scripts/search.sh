#!/bin/bash

if [ -z "$1" ]; then
    # показываем список приложений
    exit 0
fi

# если нажали enter и ничего не выбрали — ищем в браузере
xdg-open "https://google.com/search?q=$1"
