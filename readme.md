# dotfiles

My dotfiles setup for macOS. Uses Homebrew to install terminal software and creates symlinks for configs.

## What's Included

- **brew.sh**: Installs terminal software via Homebrew (fzf, zoxide, eza, fd, bat, starship)
- **install.sh**: Interactive installer that runs brew.sh and sets up config symlinks

## Usage

```bash
./install.sh
```

The installer will prompt you for:
1. Installing Homebrew and terminal software
2. Creating config symlinks (currently supports ghostty)

## Configs

- Ghostty terminal config (`config/ghostty/`)
- Helix editor config (`config/helix/`)
- Starship prompt config (`config/starship.toml`)
- Zsh config (`config/.zshrc`)
- Settings (`settings.json`)