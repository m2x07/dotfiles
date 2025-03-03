# Shell Options
setopt alwaystoend
setopt append_history
setopt autocd
setopt autopushd
setopt completeinword
setopt extended_history
setopt hist_ignore_space
setopt histverify
setopt inc_append_history
setopt interactivecomments
setopt longlistjobs
setopt no_hist_beep
setopt promptsubst
setopt pushdignoredups
setopt pushdminus
setopt share_history

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

# Plugin Manager: zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d $ZINIT_HOME ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

# Loading Plugins
zinit load zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-autosuggestions
zinit load MichaelAquilina/zsh-you-should-use
zinit load MichaelAquilina/zsh-auto-notify

autoload -U compinit && compinit
_comp_options+=(globdots)

zinit cdreplay -q

# ENV Exports
export AUTO_NOTIFY_THRESHOLD=10
AUTO_NOTIFY_IGNORE+=("docker" "weechat" "npm run dev" "npm start" "cava" "bat" "gpg" "gpg2" "ping" "waybar" "imv")

# Keybinds
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Completion stuff
zstyle ":completion:*" matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completion:*" menu select

GPG_TTY=$(tty)
export GPG_TTY

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

## Aliases
alias ls="lsd --group-directories-first"
alias l="lsd -l --group-directories-first"
alias ll="lsd -al --group-directories-first"
alias nv="nvim"
alias nf="neofetch"
alias open="xdg-open"
alias history="history -fED 0"
alias tree="tree -CaI \"node_modules|.git\" --dirsfirst"
alias d="dirs -v"
alias pwdcp="pwd | tr -d '\n' | wl-copy"
alias grep="grep -i --color=always"
alias 0="cd ~0"
alias 1="cd ~1"
alias 2="cd ~2"
alias 3="cd ~3"
alias 4="cd ~4"
alias 5="cd ~5"
alias 6="cd ~6"
alias 7="cd ~7"
alias 8="cd ~8"
alias 9="cd ~9"
alias 10="cd ~10"
alias 11="cd ~11"
alias 12="cd ~12"

# FZF setup
export FZF_CTRL_T_OPTS='--preview="head -15 {}"'
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --border sharp'
source <(fzf --zsh)

export GOPATH=$HOME/.local/go
export MANPAGER="nvim +Man! -c 'set scrolloff=0'"

# Prompt
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
else
    print -P "%F{#ff0000}>>> ERROR: %F{cyan}starship%F{#ff0000} prompt not installed.%f"
    print -P "%F{cyan}>>> INFO: Installing now:%f"
    sudo pacman -S starship
    if [[ $? -ne 0 ]]; then
        print -P "%F{#ff0000}>>> ERROR: Not an Arch linux distribution. Please install %F{cyan}starship %F{#ff0000}manually.%f"
    else
        eval "$(starship init zsh)"
    fi
fi
