# theming dependencies

pywal16 colors for every app. This repo holds stow packages: `wal` (the core) and one package per app whose only config is its theming. Apps with their own repo (`ghostty`, `hyprland`, `zsh`) carry their theming pieces themselves and work without this repo.

Stow these packages **from this directory** (`cd theming`), not from the superproject root; this repo's `.stowrc` passes `--target=~ --no-folding`. Stow `wal` first, then only the packages for apps that are installed:

```sh
cd theming
stow -n -v wal firefox gtk qtengine vesktop vicinae   # dry run
stow -v wal firefox gtk qtengine vesktop vicinae
```

## How it fits together

- `wal --theme <name>` or `wal -i <wallpaper>` writes colors to `~/.cache/wal/`: `colors.json`, pywal16's built-in templates, and the templates in `~/.config/wal/templates/`.
- Passing `-o ~/.config/wal/post-wal.sh` makes wal run that script afterwards. It runs every executable `~/.config/wal/post-wal.d/*.sh`, the reload hooks that stowed packages (here and in the app repos) add. Without `-o` the files update but running apps don't.
- Every template and app theme uses only the 16 slots plus background, foreground and cursor, so a wallpaper-generated scheme and the committed Wisteria Dusk scheme are interchangeable.

## Packages

| Package | Links | Needs | Install docs |
|---|---|---|---|
| `wal` (required for all others) | `~/.config/wal/post-wal.sh`, `~/.config/wal/colorschemes/dark/wisteria-dusk.json` | pywal16. Installed here with pipx (`pipx install pywal16`); the CachyOS repos also ship `python-pywal16`. ImageMagick only for `wal -i` | https://github.com/eylles/pywal16/wiki/Installation |
| `firefox` | `post-wal.d/firefox.sh` (runs `pywalfox update`) | Firefox, the Pywalfox add-on, and its native host: `pipx install pywalfox && pywalfox install`. The hook does nothing without `pywalfox` | https://github.com/Frewacom/pywalfox#installation |
| `gtk` | `templates/gtk.css`, `post-wal.d/gtk.sh` (copies the rendered CSS to `~/.config/gtk-{3,4}.0/gtk.css`) | `adw-gtk-theme`, selected as the GTK 3 theme: `gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark` and `gsettings set org.gnome.desktop.interface color-scheme prefer-dark`. GTK 4 uses libadwaita. Running apps recolor on restart | https://github.com/lassekongo83/adw-gtk3 |
| `qtengine` | `~/.config/qtengine/config.json`, `templates/qtengine.colors` | qtengine with `QT_QPA_PLATFORMTHEME=qtengine` (the `hyprland` package sets it), the Darkly style (`darkly-qt6-git`, AUR) and `breeze-icons` (`breeze-dark`). Qt apps recolor on restart | https://github.com/kossLAN/qtengine |
| `vesktop` | `~/.config/vesktop/themes/wal.theme.css`, `post-wal.d/vesktop.sh` (copies wal's `colors.css` into that folder as `wal-colors.css`) | Vesktop. After the first `wal`, enable both **Wal** and **Wal colors** under Settings → Themes. The theme imports refact0r's Midnight from the web; the Figtree font is optional | https://github.com/Vencord/Vesktop |
| `vicinae` | `templates/vicinae.toml`, `post-wal.d/vicinae.sh` (copies it to `~/.local/share/vicinae/themes/wal.toml`) | Vicinae. The hook only copies into an existing folder, so run `mkdir -p ~/.local/share/vicinae/themes` once, then pick **Wal** in Vicinae's settings | https://vicinae.com/docs |

Install commands (copied from the linked docs for convenience; if they disagree, the linked docs win):

```sh
# Arch / CachyOS
sudo pacman -S --needed python-pipx adw-gtk-theme breeze-icons
pipx install pywal16
pipx install pywalfox && pywalfox install   # then add the Pywalfox add-on in Firefox
yay -S qtengine darkly-qt6-git              # AUR, or any AUR helper
mkdir -p ~/.local/share/vicinae/themes
```

## Apply a colorscheme

```sh
wal --theme wisteria-dusk -o ~/.config/wal/post-wal.sh   # the committed scheme
wal -i ~/Pictures/wallpaper.png -o ~/.config/wal/post-wal.sh   # or one from a wallpaper
```

`~/.cache/wal/` persists across reboots, so this is only needed once per machine and on each change.

## Verify

```sh
command -v wal >/dev/null && echo "wal ok" || echo "wal MISSING"
test -x ~/.config/wal/post-wal.sh && echo "post-wal ok" || echo "post-wal MISSING"
test -f ~/.cache/wal/colors.json && echo "colors ok" || echo "colors MISSING (run wal)"
ls ~/.config/wal/post-wal.d/   # one hook per stowed app
```
