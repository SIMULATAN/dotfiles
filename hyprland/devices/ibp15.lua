hl.device({
    name = "uniw0001:00-093a:0255-touchpad",
    sensitivity = 0.15,
})

local function init_monitors()
  local monitors = #hl.get_monitors()

  hl.monitor({
    output = "eDP-1",
    mode = "2560x1600@144",
    position = monitors > 1 and "3440x480" or "0x0",
    scale = monitors > 1 and 1.3333 or 1.07,
  })
end

hl.on("config.reloaded", init_monitors)
hl.on("monitor.added", init_monitors)
hl.on("monitor.removed", init_monitors)

for i=0,20 do
  hl.workspace_rule({
    workspace = tostring(i),
    monitor = i <= 10 and "DP-2" or "eDP-1",
  })
end

