set -xe

KEYS_GNOME_WM=/org/gnome/desktop/wm/keybindings
KEYS_GNOME_SHELL=/org/gnome/shell/keybindings
KEYS_MUTTER=/org/gnome/mutter/keybindings
KEYS_MEDIA=/org/gnome/settings-daemon/plugins/media-keys

# Toggle window fullscreen
dconf write ${KEYS_GNOME_WM}/toggle-fullscreen "['<Super>f']"
# Increase and decrease text size
dconf write ${KEYS_MEDIA}/decrease-text-size "['<Super>minus']"
dconf write ${KEYS_MEDIA}/increase-text-size "['<Super>equal']"
# Custom
dconf write ${KEYS_MEDIA}/custom-keybindings/custom0/command "'vpn.sh'"
dconf write ${KEYS_MEDIA}/custom-keybindings/custom0/binding "'<Shift><Super>V'"
dconf write ${KEYS_MEDIA}/custom-keybindings/custom0/name "'Toggle CRG VPN'"
