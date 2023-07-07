if status is-interactive
    # Commands to run in interactive sessions can go here
    # set fish_greeting
    
    set fish_greeting
    
    set -gx EDITOR nvim

    # Vi mode
    fish_vi_key_bindings
    # Emacs mode
    #fish_default_key_bindings
    
    # ========================================================================================
    
    # ALIASES
    # alias automatically appends $argv, so that all parameters used with the alias are passed to the actual command.
    
    # Git
    alias gp 'git push'
    alias gcom 'git add . && git commit'
    alias gst 'git status'
    alias gcl 'git clone'
    alias glog 'git log --oneline --decorate --graph'
    
    # X11 settings
    alias noblackscreen 'xset s off; xset -dpms; xset s noblank'
    
    # HDMI monitor
    alias start-HDMI 'xrandr --output HDMI-1-0 --mode 1366x768 --auto --right-of eDP-1 && sleep 2 && leftwm command SoftReload'
    alias stop-HDMI 'xrandr --output HDMI-1-0 --off && sleep 2 && leftwm command SoftReload'
    
    # Terminal
    alias .. 'cd ..'
    alias ... 'cd ../..'
    alias ls 'exa'
    alias l 'exa -l'
    alias la 'exa -la'
    alias lr 'exa -lR'
    alias ra 'ranger'
    alias cat 'bat'
    alias ti 'date +"%H : %M" | figlet -f standard | lolcat -r'
    
    # Systemctl
    alias sc 'sudo systemctl'
    
    # Start ssh agent with key
    alias gu 'ssh-add ~/.ssh/id_ed25519 && gitui'
    
    # Neovide
    alias nv 'neovide --multigrid'
    # Neovim
    alias v 'nvim'

    # Animated background
    alias animvid-gpu 'prime-run xwinwrap -g 1920x1080 -ov -ni -s -nf -un -fs -b -- mpv --hwdec=vdpau --vo=gpu -wid WID --loop --no-border --no-config --no-window-dragging --no-input-default-bindings --no-osd-bar --no-sub --no-audio'
    
    # ========================================================================================
    
    # FUNCTIONS
    
    function prime-run --description "Run program using the nvidia GPU"
        __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only $argv &> /dev/null &
    end
    
    function t --description "Send file to trash"
     if ! test -d ~/Trash
         mkdir ~/Trash
     end
     mv $argv ~/Trash
    end 
    
    function p --description "Run a program in the background silently"
        $argv &> /dev/null &
    end
    
    function o --description "Open a file with the default application"
        xdg-open "$argv" &> /dev/null &
    end
    
    function makedir --description "Make a new directory and cd into it"
        mkdir -p "$argv" && cd "$argv"
    end
    
    function extract --description "Extract archives"
        if test -f "$argv"
            switch "$argv"
                case "*.tar.gz"
                    tar -xzvf "$argv"
                case "*.bz2"
                    bunzip2 "$argv"
                case "*.rar"
                    unrar x "$argv"
                case "*.tar"
                    tar -xvf "$argv"
                case "*.tbz2"
                    tar -xjvf "$argv"
                case "*.tgz" 
                    tar -xzvf "$argv"
                case "*.zip"
                    unzip "$argv"
                case "*.Z"
                    uncompress "$argv"
                case "*.7z"
                    7z x "$argv"
                case "*"
                    printf "%s" "Unrecognized file extension"
            end
        else
            printf "%s" "The file does not exist"
        end
    end

    function f --description "Search and open files"
        xdg-open (fzf) &> /dev/null &
    end

    function hi --description "Search history file for a command"
        history | fzf | read -l result 
        
        if test $result
            commandline -rb $result
        end
    end
    
    # ========================================================================================
    
    # KEYBINDINGS
    
    # bind \cp 'cmus'
    # bind \ch 'htop'
    # bind \ee 'nvim'
    
    # ========================================================================================
    
    date +"%H : %M" | figlet -f standard | lolcat -r
    
    # Update PATH
    fish_add_path ~/.cargo/bin ~/.ghcup/bin ~/Downloads/AppImages
    
    # Init zoxide (cd)
    zoxide init fish | source
    # Init starship prompt (must be last)
    starship init fish | source

end
