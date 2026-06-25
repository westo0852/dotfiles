# Powerlevel10k instant prompt

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zsh settings

setopt histignorealldups sharehistory inc_append_history interactive_comments
bindkey -e # for now!

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# Completion

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select=2
eval "$(dircolors -b 2>/dev/null)" # Suppress error if dircolors is missing
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

# Define functions here

dev()  { cd "$PATH_TO_DEV"; }
docs() { cd "$PATH_TO_DOCS"; }
dots() { cd "$PATH_TO_DOTS"; }
sbl()  { cd "$HOME/sbl"; }

setup_work_macos() {
  # Java: Override with .envrc e.g. export JAVA_HOME=$(/usr/libexec/java_home -v 17)
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

  # Local install of Gradle, but can use wrapper
  [[ -d "$HOME/gradle-6.9.3/bin" ]] && export PATH="$HOME/gradle-6.9.3/bin:$PATH"

  # Trying SQLcl for Oracle DB
  [[ -d "$HOME/sqlcl/bin" ]] && export PATH="$HOME/sqlcl/bin:$PATH"

  # Misc
  export PATH="$PATH:$HOME/go/bin"
}

setup_work_linux() {
  # Java as devcontainer feature
  if [[ -L "/usr/lib/jvm/default" ]]; then
    export JAVA_HOME="/usr/lib/jvm/default"
  elif [[ -L "/usr/lib/jvm/zulu1.8" ]]; then
    export JAVA_HOME="/usr/lib/jvm/zulu1.8"
  fi

  # TODO Create gradle symlink in $HOME/.local/bin

  # Added by rustup installer
  [[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

  # Powerlevel10k, themes and plugins
  source "$HOME/.p10k.zsh"
  source "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme"
  source "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  source "/usr/share/doc/fzf/examples/key-bindings.zsh"
  source "/usr/share/doc/fzf/examples/completion.zsh"
}

setup_home() {
  # Provides credentials to ssh-agent if ran systemctl --user enable --now ssh-agent
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

  # Java
  if [[ -L "/usr/lib/jvm/default" ]]; then
    export JAVA_HOME="/usr/lib/jvm/default"
  fi

  # Powerlevel10k, themes and plugins
  source "$HOME/.p10k.zsh"
  source "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme"
  source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
  source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  source "/usr/share/fzf/key-bindings.zsh"
  source "/usr/share/fzf/completion.zsh"
}

# Setup by environment
# TODO Add work specific aliases e.g. ssh into boxes or devcontainer

local os_type="$(uname -s)"
case "$os_type" in
  Darwin)
    setup_work_macos
    PATH_TO_DOCS="$HOME/OneDrive - Macquarie Group/Documents/notes"
    PATH_TO_DOTS="$HOME/sbl/dots"
    ;;

  Linux)
    local id_distro=$(awk -F '[="]' '$1=="ID" {print $2}' /etc/os-release)
    case "$id_distro" in
      debian|ubuntu)
        setup_work_linux
        PATH_TO_DEV="$WORKSPACE"
        PATH_TO_DOTS="/dotfiles"
        ;;
      *)
        setup_home
        PATH_TO_DEV="$HOME/dev"
        PATH_TO_DOCS="$HOME/docs"
        PATH_TO_DOTS="$HOME/dotfiles"
        ;;
    esac
    ;;

  *) echo "Limited setup due to unknown OS: uname -s not in 'Darwin', 'Linux'" ;;
esac

# Common setup

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
[[ -n "$JAVA_HOME" ]] && export PATH="$JAVA_HOME/bin:$PATH"

# Aliases

export LESS='-R'
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases" 

# Removing git checkout commands until I remember to use git switch instead
gco() { echo 'Did you mean to run git checkout? Can you use git switch (alias: gsw) or git switch - (alias: gswb) instead?'; return 1; }
gcob() { echo 'Did you mean to run git checkout -b? Can you use git switch -c (alias: gswc) instead?'; return 1; }

# Other tools

if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]]  && source "$NVM_DIR/bash_completion"
fi

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Cleanup

typeset -U path PATH # Ensure no duplicate entries in PATH
unfunction setup_home setup_work_linux setup_work_macos

# Start tmux

if command -v tmux >/dev/null 2>&1 && \
  [[ -z "$TMUX" && "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]] && \
  ! tmux list-sessions >/dev/null 2>&1; then

  tmux new -s dev
fi
