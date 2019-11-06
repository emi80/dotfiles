# dotfiles

```
autorandr  > automatic display configuration
dunst      > notification daemon
git        > git config and aliases
i3         > tiling window manager
mpd        > music player daemon config
ncmpcpp    > mpd client config
ranger     > file manager
readline   > readline config
redshift   > screen color temperature 
rofi       > application launcher
scripts    > some automation scripts
vim        > vim editor config
vpn        > openfortivpn config
wal        > wal config
x          > X11 config files
xcompose   > Xcompose config
xsettingsd > xsettings daemon config
zathura    > zathura pdf reader config
zsh        > oh-my-zsh plugins and themes
```

# Usage

I use [stow](https://www.gnu.org/software/stow/) to manage my dotfiles
```
git clone https://github.com/emi80/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow zsh # ...and whatever else you want
```