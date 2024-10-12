# Shell Options
setopt append_history
setopt inc_append_history
setopt share_history
setopt extended_history
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt no_hist_beep
setopt autocd
setopt promptsubst

# History
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

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
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git

autoload -U compinit && compinit
_comp_options+=(globdots)

zinit cdreplay -q

# Prompt
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# ENV Exports
export AUTO_NOTIFY_THRESHOLD=10
AUTO_NOTIFY_IGNORE+=("docker" "weechat" "npm run dev" "npm start" "cava" "bat")

# Keybinds
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Completion stuff
zstyle ":completion:*" matcher-list 'm:{a-z}={A-Za-z}'
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
alias history="history 0"
alias tree="tree -CaI \"node_modules|.git\" --dirsfirst"

eval "$(fzf --zsh)"
