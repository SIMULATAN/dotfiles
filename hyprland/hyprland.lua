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

  decoration = {
    rounding = 10,
    blur = {
      size = 8,
      passes = 2,
    },
  },

  cursor = {
    zoom_rigid = true,
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

local function animation(leaf, speed, style)
    hl.animation({ enabled = true, curve = "default", spring = "default", leaf = leaf, speed = speed, style = style })
end

animation("windows", 4)
animation("windowsOut", 7, "popin 80%")
animation("border", 10)
animation("fade", 7)
animation("workspaces", 3)
animation("specialWorkspace", 5, "slidefadevert -50%")

require("workspaces")
require("binds")
require("rofi")

require("monitors")

