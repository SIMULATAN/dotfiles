# Dotfiles (Dracula)
Hello and welcome to my dotfiles repository!

This repo contains the most important config files from my linux installations.

I configured most of the things in this repo to follow the [**dracula theme color palette**](https://draculatheme.com/contribute#color-palette).

## Screenshots
![Desktop with neofetch, cmatrix, polybar, i3, dunst, and my volume notification](https://i.imgur.com/xX5x5A6.png)
|![Volume Notification with a song playing](https://i.imgur.com/LR2Ifba.png)|![Volume Notification with a more vibrant background image](https://i.imgur.com/immNHv7.png)|
|--|--|
|Volume Notification with a song playing|Volume Notification with a more vibrant background image|

|![i3lock-color setup](https://i.imgur.com/BhNfnjD.png)|
|--|
|i3lock-color (vanilla `i3lock` is also supported)|



## Software
_note: "Package" refers to dotters packages_
|Category|(Package-)Name|
|--|--|
|WM|i3|
|Terminal|kitty|
|Shell|zsh|
|Bar|polybar|
|Compositor|picom|
|Editor|neovim|
|Notifications|dunst|
|Specs Display|neofetch|
|Utility Scripts|volume, i3lock (package "bin")|

## Fonts
[Fontawesome](https://use.fontawesome.com/releases/v6.1.1/fontawesome-free-6.1.1-desktop.zip
) and [JetBrains Mono Nerd](https://github.com/ryanoasis/nerd-fonts)
_links lead to the things downloaded by the script_

Install these fonts either manually or by running the `install-fonts.sh` script in the root dir of the repo.

## How to install my dotfiles
### Installing dependencies
Required packages for the different packages / configs can be found in the `.packages` file of the config directory (made on arch, which means that most required packages should be included. For example, `xcwd` is pre-installed on fedora, meaning you wouldn't be able to tell that it's a dependency that needs to be installed elsewhere).

My recommendation is to craft a simple script that installs the required dependencies with your package manager.
For example (pacman): `sudo pacman -S $(cat .packages | sed '/#/d' | grep -v "^[?]" | tr -d '>+?' | tr '\n' ' ')`
This script will install all dependencies *except* packages that are prefixed with `?` (packages that can be useful but aren't requried). To ignore more dependencies, add the prefix char to the  `grep` call in the `[]`, for example: `^[?]` -> `^[?+]` to only install required packages (and the core)

#### `.packages` syntax
- `PACKAGE`: this package is _required_
- `>PACKAGE`: this package is the _core_ of the package, for example `i3-gaps` for the `i3` config.
- `+PACKAGE`: this package is _not required_, but _recommended_
- `?PACKAGE`: this package is _not required_, but _can be useful_
- `# COMMENT`: these lines contain comments regarding the package, like when you should install it or what it's useful for, these lines should be skipped in your install script

### Installing the configs
I use [dotter](https://github.com/SuperCuber/Dotter) to manage the dotfiles and bring them to the right place, see [it's wiki](https://github.com/SuperCuber/dotter/wiki).
Essentially, clone and just run `./dotter deploy` after adding `packages = [ "package1", "package2" ]` _(note: find the available packages in the `.dotter/global.toml` file)_ to your `.dotter/local.toml`. That'll symlink or copy your files in place.

## Configuring and variables

This section will show the available variables as of `788240a`, read the source to find out the current variables.

### zsh
- `theme`: the OhMyZSH theme name, see [their wiki](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)
- `plugins`: the plugins to use in OhMyZSH
- `plugins_extra`: if you want to have additional plugins on top of the default of the `plugins` variable, add the names here.
- `prompt_replacement`: a [shell parameter expansion](https://stackoverflow.com/a/13210909) that controls the ZSH `PROMPT`, useful if you only want to change a small part of the prompt from your theme, like displaying `/home/user` instead of `~` (`${PROMPT/\\%c/\\%d}`)
- `editor`: what editor to use (sets the `EDITOR` env variable)
- `java_dir`: my ZSHRC will search this location for the newest available java installation and configure the shell to use that one. Useful if you install java through IntelliJ and can't be bothered to manually update the shell to use the newest update
### i3
- `file_manager`: the file manager to open when pressing `super + e`
- `terminal`: the terminal to open when pressing `super + t`
- `terminal_arguments`: arguments to add to the `terminal` executeable, for example `xcwd` (outputs the directory open in the terminal that's currently focused, tested in kitty) like this: `$(xcwd)`
- `auto_restart_i3`: whether to restart i3 when dotter deploys changes
### polybar
- `keyboard_id`: the ID of the keyboard to use for the [hackspeed](https://github.com/polybar/polybar-scripts/tree/686f211546b77ced32a8487fe8c2a48f3b59c190/polybar-scripts/info-hackspeed) module
  get by running `xinput test-xi2 --root | grep \(KeyPress\) -A 1`, typing something, and then reading the `device` field
- `battery_id`: the ID of the battery to display in polybar
  get by running `ls -1 /sys/class/power_supply/`

## Available scripts
- `bin/volume.sh`: call to send a volume notification, [see above](#Screenshots)
- `bin/lock.sh`: locks the screen with either `i3lock-color` or vanilla `i3lock`, depending on what you have installed
- `install-fonts.sh`: installs the necessary fonts

