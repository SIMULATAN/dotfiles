To allow using `git config --global` to set properties, the config in this directory is deployed to `~/.config/git/config.global`. To enable it, add this to your global git config (`~/.gitconfig` or `~/.git/config`):

```
[include]
	path = ~/.config/git/config.global
```
