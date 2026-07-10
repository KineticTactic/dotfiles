#!/usr/bin/env zsh

update_wifi() {
    SSID=$(macwifi-cli info 2>/dev/null | awk 'NR==2 {print $1}')
    
    if [ -n "$SSID" ] && [ "$SSID" != "SSID" ]; then
        sketchybar --set $NAME label="$SSID" label.drawing=yes icon.color=0xff458588
    else
        sketchybar --set $NAME label="Off" label.drawing=yes icon.color=0xffcc241d
    fi
}

case "$SENDER" in
"mouse.clicked")
    open x-apple.systempreferences:com.apple.preference.network?WiFi
    ;;
*)
    update_wifi
    ;;
esac