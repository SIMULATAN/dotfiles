-- monitors
hl.monitor({
  output = "desc:Dell Inc. DELL P3424WEB 5F4XJ04",
  position = "0x0",
  mode = "3440x1400@60",
})

hl.monitor({
  output = "eDP-1",
  position = "3440x480",
  mode = "2560x1600@144",
  scale = 1.3333,
})

for i=0,10 do
  hl.workspace_rule({
    workspace = tostring(i),
    monitor = "DP-2",
  })
end

for i=11,20 do
  hl.workspace_rule({
    workspace = tostring(i),
    monitor = "eDP-1",
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
