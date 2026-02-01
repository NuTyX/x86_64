if [ -n "$XDG_DATA_HOME" ] && [ -d "$XDG_DATA_HOME/flatpak/exports/bin" ]; then
  pathappend "$XDG_DATA_HOME/flatpak/exports/bin"
elif [ -n "$HOME" ] && [ -d "$HOME/.local/share/flatpak/exports/bin" ]; then
  pathappend "$HOME/.local/share/flatpak/exports/bin"
fi
if [ -d /var/lib/flatpak/exports/bin ]; then
  pathappend /var/lib/flatpak/exports/bin
fi
