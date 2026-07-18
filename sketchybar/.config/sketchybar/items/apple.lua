local colors = require("colors")
local icons = require("icons")

sbar.add("item", "heart", {
  icon = {
    font = { size = 16.0 },
    string = icons.heart,
    color = colors.love,
    padding_right = 8,
    padding_left = 8,
  },
  label = { drawing = false },
  click_script = "sketchybar --reload"
})
