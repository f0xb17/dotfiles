#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

SYMLINK_APPS=(
    helix
    ghostty
)

read -r -p "Install Homebrew and terminal software? [y/N] " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    bash "$DOTFILES_DIR/brew.sh"
fi

read -r -p "Create config symlinks? [y/N] " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    for app in "${SYMLINK_APPS[@]}"; do
        src="$DOTFILES_DIR/$app"
        dest="$CONFIG_DIR/$app"
        if [[ -d "$src" ]]; then
            if [[ -L "$dest" ]] || [[ -e "$dest" ]]; then
                echo "Skipping $app: already exists"
            else
                ln -s "$src" "$dest"
                echo "Linked: $app"
            fi
        fi
    done
fi

echo "Done."
