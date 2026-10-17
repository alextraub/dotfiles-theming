#!/bin/sh
# Firefox: the Pywalfox extension re-reads colors.json when its native host (pipx's
# pywalfox) tells it to; does nothing when Firefox isn't running
command -v pywalfox >/dev/null && pywalfox update >/dev/null 2>&1
exit 0
