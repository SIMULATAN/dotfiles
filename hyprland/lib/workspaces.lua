require("lib/utilities")

function Bind_Window_To_Workspace(workspace, match)
  hl.window_rule({
    match = ({
      class = match.class,
      title = "^" .. match.title .. ".*$",
    }),
    workspace = workspace,
  })
end

function Create_Overlay_Workspace(name, keybind, workspace_options)
  hl.workspace_rule(Merge({
    workspace = "special:" .. name,
    gaps_out = 100,
  }, workspace_options))

  hl.bind("CTRL + ALT + " .. keybind, hl.dsp.workspace.toggle_special(name))
end
