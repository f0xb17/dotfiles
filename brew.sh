#!/bin/bash
set -euo pipefail

TERMINAL_SOFTWARE=(
  fzf
  zoxide
  eza
  fd
  bat
  starship
)

install_from_array() {
    local -ra software=("$@")
    for pkg in "${software[@]}"; do
        if brew list --cask "$pkg" 2>/dev/null || brew list --formula "$pkg" 2>/dev/null; then
            echo "Already installed: $pkg"
        else
            echo "Installing: $pkg"
            if brew install "$pkg"; then
                true
            else
                brew install --cask "$pkg"
            fi
        fi
    done
}

if command -v brew &>/dev/null; then
    echo "Homebrew already installed"
else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Updating Homebrew..."
brew update

echo "Installing terminal software..."
install_from_array "${TERMINAL_SOFTWARE[@]}"

echo "Cleaning up..."
brew cleanup
