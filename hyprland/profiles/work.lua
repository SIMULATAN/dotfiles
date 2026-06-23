-- monitors
hl.monitor({
  output = "desc:Dell Inc. DELL P3424WEB 5F4XJ04",
  position = "0x0",
  mode = "3440x1400@60",
})

local function init_monitors()
  local monitors = #hl.get_monitors()

  hl.monitor({
    output = "eDP-1",
    mode = "2560x1600@144",
    position = monitors > 1 and "3440x480" or "0x0",
    scale = monitors > 1 and 1.3333 or 1,
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

-- special workspaces
Create_Overlay_Workspace("music", "A", { on_created_empty = "firefox -P personal" })

-- ms teams
hl.workspace_rule({
  workspace = "name:T",
  monitor = "eDP-1"
})

hl.bind("SUPER + dead_circumflex", hl.dsp.focus({ workspace = "name:T" }))
Bind_Window_To_Workspace("name:T", { title = "Microsoft Teams" })
