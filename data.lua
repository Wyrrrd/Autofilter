--data.lua

data:extend(
{
  {
    type = "tips-and-tricks-item",
    name = "autofilter",
    tag = "[entity=inserter]",
    category = "inserters",
    indent = 1,
    order = "g",
    dependencies = {"inserters"},
  },
  {
    type = "custom-input",
    name = "autofilter",
    key_sequence = "CONTROL + SHIFT + A",
    consuming = "game-only",
    action = "lua"
  },
  {
    type = "shortcut",
    name = "autofilter",
    action = "lua",
    order = "h[combatRobot]",
    technology_to_unlock = "electronics",
    associated_control_input = "autofilter",
    toggleable = true,
    icon = "__Autofilter__/graphics/autofilter.png",
    icon_size = 32,
    small_icon = "__Autofilter__/graphics/autofilter-small.png",
    small_icon_size = 24,
    unavailable_until_unlocked = true,
  },
})