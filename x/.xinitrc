#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# keyboard
setxkbmap -layout us
setxkbmap -option eurosign:5
setxkbmap -option compose:ralt

xrdb -merge ~/.Xresources

#export PATH=$HOME/bin:$PATH
#export $(gnome-keyring-daemon -s)
#eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
#export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)

xrandr --dpi 118
autorandr --change

export TERMINAL=xst

#exec $STARTUP i3
exec dbus-launch --sh-syntax --exit-with-session i3
