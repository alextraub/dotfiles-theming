#!/bin/sh
# Vicinae: copy the rendered templates/vicinae.toml into its user themes folder as the
# "wal" theme (pick it in Vicinae's settings); Vicinae reloads it live (rename so it never
# reads a half-written file)
cache=${XDG_CACHE_HOME:-$HOME/.cache}/wal
vicinae=${XDG_DATA_HOME:-$HOME/.local/share}/vicinae/themes
if [ -d "$vicinae" ] && [ -f "$cache/vicinae.toml" ]; then
    cp "$cache/vicinae.toml" "$vicinae/.wal.toml.tmp" &&
        mv "$vicinae/.wal.toml.tmp" "$vicinae/wal.toml"
fi
