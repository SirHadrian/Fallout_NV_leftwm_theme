#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

# Default editor
export EDITOR=nvim

# User
if [ -n "$RANGER_LEVEL" ]; then 
    export PS1="[ranger]$PS1"
fi

# Aliases
# Git
alias gp='git push'
alias gcom='git add . && git commit'
alias gst='git status'
alias gcl='git clone'
alias glog='git log --oneline --decorate --graph'

# X11 settings
alias noblackscreen='xset s off; xset -dpms; xset s noblank'

# HDMI monitor
alias start-HDMI='xrandr --output HDMI-1-0 --mode 1366x768 --auto --right-of eDP-1 && sleep 2 && leftwm command SoftReload'
alias stop-HDMI='xrandr --output HDMI-1-0 --off && sleep 2 && leftwm command SoftReload'

# Terminal
alias ..='cd ..'
alias ...='cd ../..'
alias ls='exa'
alias l='exa -l'
alias la='exa -la'
alias lr='exa -lR'
# alias ra='ranger'
alias cat='bat'
alias ti='date +"%H : %M" | figlet -f standard | lolcat'

# Systemctl
alias sc='sudo systemctl'

# Start ssh agent with key
alias gu='ssh-add ~/.ssh/id_ed25519 && gitui'

# Neovide
# alias nv='neovide --multigrid'
alias v='neovide --maximized'
alias vv='neovide --maximized .'
# Neovim
# alias v='nvim'
# alias vv='nvim .'

# Lobster movies
alias lob='lobster --rofi -i'

# Functions
function p {
    "$@" &> /dev/null & 
}

function makedir {
    mkdir -p "$1" && cd "$1" || exit 1 
}

# Zoxide
eval "$(zoxide init bash)"
