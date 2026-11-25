#!/bin/zsh

finder_window_count="$(/usr/bin/osascript -e 'tell application "Finder" to count windows')"

if [[ "$finder_window_count" -eq 0 ]]; then
  /usr/bin/open /Users/kinetic
fi
