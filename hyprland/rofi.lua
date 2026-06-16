hl.bind("ALT + SPACE", hl.dsp.exec_cmd("pkill rofi || rofi -show drun"))

hl.bind("ALT + R", hl.dsp.submap("rofi"))
hl.define_submap("rofi", function()
  local function rofi_submap(key, command)
    hl.bind(key, function()
      if command then
        hl.dispatch(hl.dsp.exec_raw(command))
      end
      hl.dispatch(hl.dsp.submap("reset"))
    end)
  end

  rofi_submap("H", "sxhkd-keybinds.sh")
  rofi_submap("P", "power-menu.sh")
  rofi_submap("W", "wifi-menu.sh")
  rofi_submap("V", "vpn.sh")
  rofi_submap("C", "calc.sh")
  rofi_submap("E", "rofi -show emoji")
  rofi_submap("S", "rofi -show ssh")
  rofi_submap("F", "rofi -show window")
  rofi_submap("D", "rofi-dockerhub.sh")
  rofi_submap("M", "mon-switcher.sh")
  rofi_submap("T", "rofi-tuxedo-power-profile.sh")
  rofi_submap("Escape")
end)

