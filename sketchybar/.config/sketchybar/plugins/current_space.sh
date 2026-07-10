#!/usr/bin/env zsh

update_space() {
    sketchybar --set $NAME icon=
}

case "$SENDER" in
"mouse.clicked")
    sketchybar --remove '/.*/'
    source $HOME/.config/sketchybar/sketchybarrc
    ;;
*)
    update_space
    ;;
esac