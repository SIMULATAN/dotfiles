function Bind_Window_To_Workspace(workspace, match)
  hl.window_rule({
    match = ({
      class = match.class,
      title = "^" .. match.title .. ".*$",
    }),
    workspace = workspace,
  })
end
