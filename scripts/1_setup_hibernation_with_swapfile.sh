#!/usr/bin/env bash
set -euo pipefail

SWAPFILE="${1:-/swapfile}"

if [[ $EUID -ne 0 ]]; then
  echo "Run with sudo:"
  echo "  sudo $0 ${SWAPFILE}"
  exit 1
fi

if [[ ! -f "$SWAPFILE" ]]; then
  echo "Swapfile not found: $SWAPFILE"
  exit 1
fi

if ! swapon --show=NAME --noheadings | grep -qx "$SWAPFILE"; then
  echo "Warning: $SWAPFILE is not currently active as swap."
fi

UUID="$(findmnt -no UUID -T "$SWAPFILE")"

if [[ -z "$UUID" ]]; then
  echo "Could not find filesystem UUID for $SWAPFILE"
  exit 1
fi

OFFSET="$(
  filefrag -v "$SWAPFILE" |
    awk '
      $1 == "0:" {
        gsub(/\./, "", $4)
        print $4
        exit
      }
    '
)"

if [[ -z "$OFFSET" ]]; then
  echo "Could not determine resume_offset from filefrag"
  exit 1
fi

echo "Swapfile:       $SWAPFILE"
echo "Resume UUID:    $UUID"
echo "Resume offset:  $OFFSET"
echo

echo "About to run:"
echo "  grubby --update-kernel=ALL --args=\"resume=UUID=$UUID resume_offset=$OFFSET\""
echo "  dracut --regenerate-all --force"
echo

read -rp "Continue? [y/N] " confirm

case "$confirm" in
  [yY]|[yY][eE][sS])
    ;;
  *)
    echo "Cancelled."
    exit 0
    ;;
esac

echo "Updating kernel args..."
grubby --update-kernel=ALL --args="resume=UUID=$UUID resume_offset=$OFFSET"

echo "Regenerating initramfs..."
dracut --regenerate-all --force

echo
echo "Done. Reboot once, then test with:"
echo "  systemctl hibernate"
