set fish_greeting ""

### SETUP COLORS ###
set -gx TERM xterm-256color

### SETUP EZA ###
alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing

### SETUP FZF ###
fzf_configure_bindings --directory=\t

### PACMAN AND YAY ###
alias install='sudo pacman -S --needed --noconfirm'                     # Install package
alias update='sudo pacman -Syu && yay --noconfirm && flatpak update'    # Update everything
alias y='yay -S --noconfirm'                                            # Install package with Yay
alias yc='yay -Scc && yay -Yc'                                          # Clear the Cache
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias orphan='sudo pacman -Rns (pacman -Qtdq)'

### GIT STUFF ###
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias tag='git tag'
alias newtag='git tag -a'

### SETUP ZOXIDE ###
zoxide init fish | source

### SETTING THE STARSHIP PROMPT ###
starship init fish | source

### REPLACE CAT WITH BAT ###
if type -q bat
    abbr --add -g cat 'bat'v
end
