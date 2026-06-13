#!/usr/bin/env bash
set -euo pipefail

IN_DIR="${1:-$HOME/dotfiles/gnome}"

dconf load /org/gnome/shell/extensions/ < "$IN_DIR/extensions.dconf"

echo "Settings restored. Install extensions manually or with extension-manager."
