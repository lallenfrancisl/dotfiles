#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="${1:-$HOME/dotfiles/gnome}"

mkdir -p "$OUT_DIR"

gnome-extensions list --enabled > "$OUT_DIR/extensions-enabled.txt"
gnome-extensions list > "$OUT_DIR/extensions-all.txt"

dconf dump /org/gnome/shell/extensions/ > "$OUT_DIR/extensions.dconf"

echo "Saved to $OUT_DIR"
