hl.config({
    general = {
      gaps_in = 0,
      gaps_out = 0,
      border_size = 0,
    },
    decoration = {
      rounding = 0,
    },
})

Create_Overlay_Workspace("music", "A", { on_created_empty = "firefox" })
Create_Overlay_Workspace("tasks", "T", { on_created_empty = "firefox --new-window https://tasks.simulatan.me" })
hl.window_rule({
    match = { workspace = "special:tasks" },
    fullscreen_state = "0 2",
})
