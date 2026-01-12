# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input must go above this block.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt
# autoload -Uz promptinit
# promptinit

setopt histignorealldups sharehistory inc_append_history
bindkey -e

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

# zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _expand _complete _correct _approximate
# zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# p10k theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ ! -f ~/powerlevel10k/powerlevel10k.zsh-theme ]] || source ~/powerlevel10k/powerlevel10k.zsh-theme

# End of Powerlevel10k setup
export PATH="$HOME/.local/bin:$PATH"

# Homebrew
[[ ! -f "/home/linuxbrew/.linuxbrew/bin/brew shellenv)" ]] || eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Golang!
if [[ -d "/usr/local/go" ]]; then
  export PATH=$PATH:/usr/local/go/bin
fi
# export GOPATH=$HOME/go
# export PATH=$PATH:$GOPATH/bin

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Hide output so p10k doesn't complain
/usr/bin/keychain --nogui ~/.ssh/id_ed25519 > /dev/null 2>&1
if [[ -f $HOME/.keychain/$HOST-sh ]]; then
    source $HOME/.keychain/$HOST-sh > /dev/null 2>&1
fi

[[ ! -f ~/.aliases ]] || source ~/.aliases

typeset -U path
