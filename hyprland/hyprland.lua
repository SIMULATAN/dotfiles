require("lib/workspaces")

hl.on("hyprland.start", function ()
  hl.exec_cmd("waybar & hyprpaper & flameshot")
end)

hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 6,
    border_size = 2,

    layout = "dwindle",

    no_focus_fallback = true,
  },

  dwindle = {
    preserve_split = true,
    force_split = 2,
  },

  decoration = {
    rounding = 10,
    blur = {
      size = 8,
      passes = 2,
    },
  },

  cursor = {
    zoom_rigid = false,
  },

  input = {
    kb_layout = "de",

    touchpad = {
      natural_scroll = true,
    },
  },

  misc = {
    allow_session_lock_restore = true,
    middle_click_paste = false,

    force_default_wallpaper = 0,
    disable_splash_rendering = true,
  },

  binds = {
    allow_workspace_cycles = true,
  },
})

hl.curve("easeInOutQuart", { type = "bezier", points = { {0.76, 0}, {0.24, 1} } })
hl.curve("easeOutQuart", { type = "bezier", points = { {0.25, 1}, {0.5, 1} } })
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
local function animation(leaf, speed, style, bezier)
    hl.animation({ enabled = true, bezier = bezier or "easeInOutQuart", leaf = leaf, speed = speed, style = style })
end

animation("windows", 1.5)
animation("windowsOut", 2, "popin 80%", "linear")
animation("workspaces", 1)
animation("specialWorkspace", 2, "slidefadevert -50%")

hl.gesture({ fingers = 3, direction = "horizontal", scale = 2, action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", mods = "ALT", action = "close" })
hl.gesture({ fingers = 4, direction = "vertical", scale = 1.5, action = "fullscreen" })
hl.gesture({ fingers = 4, direction = "horizontal", scale = 1.5, action = "fullscreen", mode = "maximize" })

hl.gesture({ fingers = 2, direction = "pinch", mods = "ALT", action = "cursorZoom", zoom_level = 1, mode = "live" })

require("dracula")
require("workspaces")
require("windows")
require("binds")
require("rofi")

require("monitors")
