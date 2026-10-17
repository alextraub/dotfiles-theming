#!/bin/sh
# Run by pywal16 after every colorscheme change (wal -o), once the templates in
# templates/ are rendered to ~/.cache/wal/. Each app's package in the theming repo
# adds its own hook to post-wal.d/, so only the apps that are stowed get updated.

for hook in "${XDG_CONFIG_HOME:-$HOME/.config}"/wal/post-wal.d/*.sh; do
    [ -x "$hook" ] && "$hook"
done

exit 0
