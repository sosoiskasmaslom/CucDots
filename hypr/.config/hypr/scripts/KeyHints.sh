#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##

# GDK BACKEND. Change to either wayland or x11 if having issues
BACKEND=wayland

# Check if rofi or yad is running and kill them if they are
if pidof rofi > /dev/null; then
  pkill rofi
fi

if pidof yad > /dev/null; then
  pkill yad
fi

# Launch yad with calculated width and height
GDK_BACKEND=$BACKEND yad \
    --center \
    --title="Cuc Cheat Sheet" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Description: \
    --column=Command: \
    --timeout-indicator=bottom \
"ESC" "close this app" "" \
" = " "SUPER KEY (Windows Key Button)" "(SUPER KEY)" \
" H" "Launch this Quick Cheat Sheet" "" \
" SHIFT K" "Searchable Keybinds" "(Search all Keybinds via rofi)" \
"" "" "" \
" A / D" "Move" "left / right" \
" SHIFT A / D" "Move active window" "left / right" \
" CTRL A / S / W / D" "Move focus" "left / down / up / right" \
"" "" "" \
" R" "Terminal" "(kitty)" \
" B" "Launch Browser" "(Default browser)" \
" E" "Open yazi without root" "" \
" SHIFT E" "Open yazi in root" "" \
" S" "Application Launcher" "(rofi-wayland)" \
" Q" "close active window" "(not kill)" \
" Shift Q " "kills an active window" "(kill)" \
"" "" "" \
" CTRL P" "Pause media" "" \
" CTRL [" "Launch previous media" "" \
" CTRL ]" "Launch next media" "" \
"" "" "" \
" Alt V" "Clipboard Manager" "(cliphist)" \
" W" "Choose wallpaper" "(Wallpaper Menu)" \
" CTRL ALT B" "Hide/UnHide Waybar" "waybar" \
" CTRL B" "Choose waybar styles" "(waybar styles)" \
" ALT B" "Choose waybar layout" "(waybar layout)" \
" ALT R" "Reload Waybar swaync Rofi" "CHECK NOTIFICATION FIRST!!!" \
" SHIFT N" "Launch Notification Panel" "swaync Notification Center" \
" Print" "screenshot region" "(grim + slurp)" \
" SHIFT S" "screenshot region" "(swappy)" \
"ALT SHIFT S" "Screenshot active window" "active window only" \
"" "" "" \
" P" "power-menu" "(wlogout)" \
" L" "screen lock" "(hyprlock)" \
" SHIFT F" "Fullscreen" "Toggles to full screen" \
" CTL F" "Fake Fullscreen" "Toggles to fake full screen" \
" SPACEBAR" "Toggle float" "single window" \
" ALT O" "Toggle Blur" "normal or less blur" \
" CTRL O" "Toggle Opaque ON or OFF" "on active window only" \
" SHIFT G" "Gamemode! All animations OFF or ON" "Please, dont use this" \
