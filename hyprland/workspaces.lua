hl.config({
  dwindle = {
    split_width_multiplier = 1.3,
  },
})

for i=1,10 do
  local key = i % 10
  hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))

  hl.bind("ALT + " .. key, hl.dsp.focus({ workspace = i + 10 }))
  hl.bind("ALT + SHIFT + " .. key, hl.dsp.window.move({ workspace = i + 10 }))
end

hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "previous_per_monitor" }))
