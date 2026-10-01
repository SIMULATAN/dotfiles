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
Bind_Window_To_Workspace("special:music", { title = ".*Soundcloud.*" })
Bind_Window_To_Workspace("special:music", { title = ".*soundcloud.*" })


Create_Overlay_Workspace("tasks", "T", { on_created_empty = "firefox --new-window https://tasks.simulatan.me" })
hl.window_rule({
    match = { workspace = "special:tasks" },
    fullscreen_state = "0 2",
})

Bind_Window_To_Workspace("12", { title = "Discord.*" })
