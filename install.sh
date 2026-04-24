#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

SYMLINK_APPS=(
    ghostty
)

read -r -p "Install Homebrew and terminal software? [y/N] " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    bash "$DOTFILES_DIR/brew.sh"
fi

unlink_existing() {
    local -ra apps=("$@")
    for app in "${apps[@]}"; do
        dest="$CONFIG_DIR/$app"
        if [[ -L "$dest" ]]; then
            rm "$dest"
            echo "Unlinked: $app"
        fi
    done
}

create_symlinks() {
    local -ra apps=("$@")
    for app in "${apps[@]}"; do
        src="$DOTFILES_DIR/config/$app"
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
}

read -r -p "Create config symlinks? [y/N] " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    unlink_existing "${SYMLINK_APPS[@]}"
    create_symlinks "${SYMLINK_APPS[@]}"
fi

echo "Done."
