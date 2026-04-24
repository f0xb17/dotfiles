#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

SYMLINK_DIRS=(
    config/ghostty
)

SYMLINK_FILES=(
    .zshrc
    starship.toml
)

read -r -p "Install Homebrew and terminal software? [y/N] " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    bash "$DOTFILES_DIR/brew.sh"
fi

unlink_existing() {
    for item in "$@"; do
        if [[ "$item" == config/* ]]; then
            dest="$CONFIG_DIR/${item#config/}"
        else
            dest="$HOME/$item"
        fi
        if [[ -L "$dest" ]]; then
            rm "$dest"
            echo "Unlinked: $dest"
        elif [[ -e "$dest" ]]; then
            rm "$dest"
            echo "Removed: $dest"
        fi
    done
}

create_symlinks() {
    local -ra dirs=("$@")
    for item in "${dirs[@]}"; do
        if [[ "$item" == config/* ]]; then
            src="$DOTFILES_DIR/$item"
            dest="$CONFIG_DIR/${item#config/}"
        else
            src="$DOTFILES_DIR/$item"
            dest="$HOME/$item"
        fi
        if [[ -d "$src" ]] || [[ -f "$src" ]]; then
            if [[ -L "$dest" ]] || [[ -e "$dest" ]]; then
                echo "Skipping: $item already exists"
            else
                mkdir -p "$(dirname "$dest")"
                ln -s "$src" "$dest"
                echo "Linked: $item"
            fi
        fi
    done
}

read -r -p "Create config symlinks? [y/N] " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    unlink_existing "${SYMLINK_DIRS[@]}" "${SYMLINK_FILES[@]}"
    create_symlinks "${SYMLINK_DIRS[@]}" "${SYMLINK_FILES[@]}"
fi

echo "Done."
