# -- Set the directory we want to store zinit and plugins

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# -- Download Zinit, if it's not there yet

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# -- Source/Load zinit

source "${ZINIT_HOME}/zinit.zsh"

# -- Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# -- Add in snippets

zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# -- Environment Variables

export EDITOR="hx"
export VISUAL="hx"
export TERMINAL="ghostty"
export TERM="xterm-256color"
export BROWSER="brave"

# -- Path

setopt extended_glob null_glob

path=(
  $path
)

typeset -U path
path=($^path(N-/))

export PATH

# -- History

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history
setopt hist_save_no_dups

# -- Aliases

alias ls="eza -al --color=always --group-directories-first --icons --git"
alias c="clear"
alias ff="fastfetch"

alias cat="bat"
alias catnn="bat --style=numbers"
alias catn="bat --style=numbers,changes"

alias install="brew install"
alias update="brew update && brew upgrade && brew cleanup"
alias remove="brew uninstall"
alias clean='brew cleanup -s && find ~/Library/Caches -mindepth 1 -not -path "*BraveSoftware*" -exec rm -rf {} + && rm -rf ~/Library/Logs/*'

alias gp="git pull"
alias gs="git status"
alias gc="gh repo clone"
alias builds="cd ~/builds/"
alias dot="cd ~/.config/dotfiles/"

# -- Sourcing

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

autoload -Uz compinit && compinit
zinit cdreplay -q

# -- FZF-TAB

setopt GLOB_DOTS

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# -- Starship

eval "$(starship init zsh)"
