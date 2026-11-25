#!/bin/bash

AEROSPACE="/opt/homebrew/bin/aerospace"
WORKSPACE="F"
APP="com.apple.finder"

# Serialize simultaneous window-detection callbacks
LOCK="${TMPDIR:-/tmp}/aerospace-finder-grid.lock"

acquired=0
for attempt in {1..40}; do
    if mkdir "$LOCK" 2>/dev/null; then
        acquired=1
        break
    fi
    sleep 0.1
done

[[ "$acquired" -eq 1 ]] || exit 0
trap 'rmdir "$LOCK" 2>/dev/null || true' EXIT

# Let AeroSpace finish registering and moving the window
sleep 0.2

count=$("$AEROSPACE" list-windows \
    --workspace "$WORKSPACE" \
    --app-bundle-id "$APP" \
    --count)

# Only arrange at exactly 3 or 4 Finder windows
[[ "$count" -eq 3 || "$count" -eq 4 ]] || exit 0

# Avoid rebuilding an already-correct 4-window layout
if [[ "$count" -eq 4 ]]; then
    state=$("$AEROSPACE" list-windows \
        --workspace "$WORKSPACE" \
        --app-bundle-id "$APP" \
        --format '%{window-layout} %{workspace-root-container-layout}')

    correct=$(printf '%s\n' "$state" | awk \
        '$1 == "h_tiles" && $2 == "v_tiles" { n++ } END { print n+0 }')

    [[ "$correct" -eq 4 ]] && exit 0
fi

# Get Finder window IDs in AeroSpace tree order
ids=()

while IFS= read -r id; do
    [[ -n "$id" ]] && ids+=("$id")
done < <("$AEROSPACE" list-windows \
    --workspace "$WORKSPACE" \
    --app-bundle-id "$APP" \
    --format '%{window-id}')

[[ "${#ids[@]}" -eq "$count" ]] || exit 0

# Flatten existing tree before rebuilding
"$AEROSPACE" flatten-workspace-tree --workspace F

if [[ "$count" -eq 3 ]]; then

    # Root: horizontal (left / right)
    "$AEROSPACE" layout --workspace F --root h_tiles

    # Group windows 2 and 3 vertically
    "$AEROSPACE" join-with --window-id "${ids[1]}" right

elif [[ "$count" -eq 4 ]]; then

    # Root: vertical (top / bottom)
    "$AEROSPACE" layout --workspace F --root v_tiles

    # Top row: 1, 2
    "$AEROSPACE" join-with --window-id "${ids[0]}" down

    # Bottom row: initially 3, 4
    "$AEROSPACE" join-with --window-id "${ids[2]}" down

    # Swap them to get 4, 3
    "$AEROSPACE" swap --window-id "${ids[2]}" right

fi

# Make the splits evenly sized
"$AEROSPACE" balance-sizes --workspace F

