#!/usr/bin/env zsh

MAX_LENGTH=35
HALF_LENGTH=$(((MAX_LENGTH + 1) / 2))

update_track() {
    MUSIC_RUNNING=$(osascript <<EOF
tell application "System Events"
    return (name of processes) contains "Music"
end tell
EOF
)

    if [ "$MUSIC_RUNNING" != "true" ]; then
        sketchybar --set $NAME icon.color=0xffd79921 label.drawing=no
        return
    fi

    MUSIC_STATE=$(osascript -e 'tell application "Music" to get player state')

    if [ "$MUSIC_STATE" = "playing" ]; then
        TRACK=$(osascript -e 'tell application "Music" to get name of current track')
        ARTIST=$(osascript -e 'tell application "Music" to get artist of current track')

        TRACK_LENGTH=${#TRACK}
        ARTIST_LENGTH=${#ARTIST}

        if [ $((TRACK_LENGTH + ARTIST_LENGTH)) -gt $MAX_LENGTH ]; then
            if [ $TRACK_LENGTH -gt $HALF_LENGTH ] && [ $ARTIST_LENGTH -gt $HALF_LENGTH ]; then
                TRACK="${TRACK:0:$((MAX_LENGTH % 2 == 0 ? HALF_LENGTH - 2 : HALF_LENGTH - 1))}…"
                ARTIST="${ARTIST:0:$((HALF_LENGTH - 2))}…"
            elif [ $TRACK_LENGTH -gt $HALF_LENGTH ]; then
                TRACK="${TRACK:0:$((MAX_LENGTH - ARTIST_LENGTH - 1))}…"
            elif [ $ARTIST_LENGTH -gt $HALF_LENGTH ]; then
                ARTIST="${ARTIST:0:$((MAX_LENGTH - TRACK_LENGTH - 1))}…"
            fi
        fi

        sketchybar --set $NAME \
            label="${TRACK} ♪ ${ARTIST}" \
            label.drawing=yes \
            icon.color=0xff98971a

    else
        sketchybar --set $NAME \
            icon.color=0xffd79921 \
            label.drawing=no
    fi
}

case "$SENDER" in
"mouse.clicked")
    osascript -e 'tell application "Music" to playpause'
    ;;
*)
    update_track
    ;;
esac
