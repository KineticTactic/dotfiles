local colors = require("colors")
local settings = require("settings")

sbar.add("item", "widgets.music.padding.left", {
  position = "q",
  width = settings.group_paddings
})

local music = sbar.add("item", "widgets.music", {
  position = "q",
  icon = {
    string = "♫",
    color = colors.love,
    font = {
      style = settings.font.style_map["Bold"],
      size = 16.0,
    },
    padding_right = 6,
  },
  label = {
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 12.0,
    },
    color = colors.text,
    max_chars = 40,
  },
  drawing = false,
  updates = true,
  update_freq = 5,
  click_script = [[osascript -e 'tell application "Music" to playpause' >/dev/null 2>&1 || osascript -e 'tell application "Spotify" to playpause']],
})

local query = [[
osascript <<'APPLESCRIPT' 2>/dev/null
tell application "System Events"
  set procs to name of processes
  if procs contains "Music" then
    tell application "Music"
      if player state is playing then
        return (artist of current track) & "|" & (name of current track)
      end if
    end tell
  end if
  if procs contains "Spotify" then
    tell application "Spotify"
      if player state is playing then
        return (artist of current track) & "|" & (name of current track)
      end if
    end tell
  end if
end tell
return ""
APPLESCRIPT
]]

local function update_music()
  sbar.exec(query, function(result)
    result = result:gsub("%s+$", "")
    local artist, title = result:match("^([^\n]*)|([^\n]+)$")
    if title then
      local prefix = artist and artist ~= "" and (artist .. " — ") or ""
      music:set({
        drawing = true,
        label = prefix .. title,
      })
    else
      music:set({ drawing = false })
    end
  end)
end

music:subscribe({ "routine", "system_woke", "media_change", "forced" }, update_music)
sbar.trigger("forced")
