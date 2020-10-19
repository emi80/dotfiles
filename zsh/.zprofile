export PATH=$HOME/bin:$PATH

if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
	exec startx
	#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session sway
fi

# include .zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    . "$HOME/.zshrc"
fi
