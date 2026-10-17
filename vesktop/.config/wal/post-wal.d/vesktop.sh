#!/bin/sh
# Vesktop: wal.theme.css reads the CSS variables of wal's built-in colors.css, which
# Vesktop can't load from here, so copy it into Vesktop's themes folder as its own theme
# (with a header so Vencord lists it by name). Vencord reloads every enabled theme when
# a file in that folder changes. Rename so it never reads a half-written file
cache=${XDG_CACHE_HOME:-$HOME/.cache}/wal
vesktop=${XDG_CONFIG_HOME:-$HOME/.config}/vesktop/themes
if [ -d "$vesktop" ] && [ -f "$cache/colors.css" ]; then
    {
        printf '/**\n * @name Wal colors\n * @description pywal16 colors as CSS variables, for the Wal theme\n * @author dotfiles\n*/\n\n'
        cat "$cache/colors.css"
    } > "$vesktop/.wal-colors.css.tmp" &&
        mv "$vesktop/.wal-colors.css.tmp" "$vesktop/wal-colors.css"
fi
