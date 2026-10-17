#!/bin/sh
# GTK: copy the rendered templates/gtk.css over GTK 3's and GTK 4's user stylesheet (rename
# so an app starting now never reads a half-written file)
cache=${XDG_CACHE_HOME:-$HOME/.cache}/wal
config=${XDG_CONFIG_HOME:-$HOME/.config}
if [ -f "$cache/gtk.css" ]; then
    for gtk in gtk-3.0 gtk-4.0; do
        mkdir -p "$config/$gtk" &&
            cp "$cache/gtk.css" "$config/$gtk/.gtk.css.tmp" &&
            mv "$config/$gtk/.gtk.css.tmp" "$config/$gtk/gtk.css"
    done
fi
