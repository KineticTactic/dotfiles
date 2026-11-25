#!/bin/bash

AEROSPACE="/opt/homebrew/bin/aerospace"
WINDOW_ID="${AEROSPACE_WINDOW_ID:-}"

[[ -n "$WINDOW_ID" ]] || exit 0

# Allow the new window to finish moving to workspace F
sleep 0.15

count=$("$AEROSPACE" list-windows \
    --workspace F \
    --app-bundle-id com.apple.finder \
    --count)

# Leave the first two windows untouched.
# Join only the third and fourth newly spawned windows.
if [[ "$count" -eq 3 || "$count" -eq 4 ]]; then
    "$AEROSPACE" join-with --window-id "$WINDOW_ID" left
fi
