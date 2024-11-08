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

### SETUP ZOXIDE ###
zoxide init fish | source

### SETTING THE STARSHIP PROMPT ###
starship init fish | source

### REPLACE CAT WITH BAT ###
if type -q bat
    abbr --add -g cat 'bat'
end
