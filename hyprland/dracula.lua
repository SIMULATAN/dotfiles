hl.config({
  general = {
    col = {
      active_border = { colors = { "rgb(44475a)", "rgb(bd93f9)" }, angle = 225 },
      inactive_border = "rgba(44475aaa)"
    },
  },
})

hl.window_rule({
  match = {
    xwayland = true,
  },
  border_color = "rgb(ff5555)",
})
