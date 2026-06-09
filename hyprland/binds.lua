-- programs
hl.bind("SUPER + T", hl.dsp.exec_raw("kitty"))
hl.bind("SUPER + W", hl.dsp.exec_cmd("pkill waybar; waybar"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("kitty --name BlueTUIth bluetuith"))
hl.bind("SUPER + A", hl.dsp.exec_cmd("kitty --name Pulsemixer pulsemixer"))
hl.bind("SUPER + X", hl.dsp.exec_cmd("kitty --name 'Monitor Config' nvim '{{ dotter.current_dir }}/hyprland/monitors.lua'"))
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close())

hl.bind("Print", hl.dsp.exec_raw("flameshot gui"))

-- window management
hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

-- system
hl.bind("SUPER + ALT + L", hl.dsp.exec_raw("lock.sh"))
hl.bind("SUPER + ALT + S", hl.dsp.exec_raw("suspend.sh"))
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- audio
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle; volume.sh"),
  { locked = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%; volume.sh"),
  { repeating = true, locked = true }
)
hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%; volume.sh"),
  { repeating = true, locked = true }
)

hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous; volume.sh"), { locked = true })
hl.bind("SUPER + F7", hl.dsp.exec_cmd("playerctl previous; volume.sh"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause; volume.sh"), { locked = true })
hl.bind("SUPER + F8", hl.dsp.exec_cmd("playerctl play-pause; volume.sh"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next; volume.sh"), { locked = true })
hl.bind("SUPER + F9", hl.dsp.exec_cmd("playerctl next; volume.sh"), { locked = true })

-- zoom (source: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Uncommon-tips-and-tricks/#glass-magnifier-zoom)
local MAX_ZOOM = 5
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5

---@param offset number
---@return nil
local function zoom(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({ cursor = { zoom_factor = current } })
end

local function zoom_bind(key, factor)
  hl.bind(key, function() zoom(factor) end, { repeating = true })
end

zoom_bind("SUPER + plus", 0.7)
zoom_bind("SUPER + SHIFT + plus", 1.2)
zoom_bind("SUPER + minus", -0.7)
zoom_bind("SUPER + SHIFT + minus", -1.2)

zoom_bind("ALT + mouse_down", 0.5)
zoom_bind("ALT + mouse_up", -0.5)
