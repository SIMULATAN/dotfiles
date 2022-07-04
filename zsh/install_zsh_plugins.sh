mkdir -p ~/.zsh-plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh-plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo Please add \'plugins_extra = "zsh-autosuggestions"\' into your \'.dotter/local.toml\' file!
