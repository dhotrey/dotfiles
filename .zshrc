#!/usr/bin/env zsh
source ~/.config/zsh/zsh-defer/zsh-defer.plugin.zsh
# zmodload zsh/zprof
# =============================================================================
# ZSH Configuration
# =============================================================================
# # Faster path lookups
# setopt PATH_DIRS
# # Disable backgrounding completions to save forks
# unsetopt BG_NICE
# -----------------------------------------------------------------------------
# Oh-My-Zsh Configuration
# -----------------------------------------------------------------------------
DISABLE_AUTO_UPDATE="true"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME='intheloop'

# Oh-My-Zsh Settings
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

# Oh-My-Zsh Plugins
plugins=(
    git
    ssh-agent
    python
    golang
    gitignore
    copyfile
    copypath
    colored-man-pages
    # command-not-found
    # zsh-syntax-highlighting
)
zstyle :omz:plugins:ssh-agent identities id_rsa
zstyle :omz:plugins:ssh-agent lifetime 4h
# Only check completions once a day
# Define completion cache path
ZCOMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"

# Load Oh-My-Zsh (OMZ calls compinit internally)
# To speed it up, we can tell OMZ to be quiet
source "$ZSH/oh-my-zsh.sh"
# -----------------------------------------------------------------------------
# Environment Variables
# -----------------------------------------------------------------------------
export EDITOR="nvim"
export BUN_INSTALL="$HOME/.bun"

# -----------------------------------------------------------------------------
# PATH Configuration
# -----------------------------------------------------------------------------
typeset -U path  # Keep unique entries in path array
path=(
    "$HOME/.local/bin"
    "$HOME/.local/share/bob/nvim-bin"
    "$HOME/.local/scripts"
    "$GOROOT/bin"
    "$BUN_INSTALL/bin" 
    "/home/linuxbrew/.linuxbrew/bin"
    "$HOME/.cargo/bin"
    "${path[@]}"
)

export PATH

# -----------------------------------------------------------------------------
# External Tools Integration
# -----------------------------------------------------------------------------

# Zoxide
eval "$(zoxide init zsh --cmd cd)"

# Restore FZF Pretty View 
[[ -f /usr/share/fzf/shell/key-bindings.zsh ]] && source /usr/share/fzf/shell/key-bindings.zsh
[[ -f /usr/share/fzf/shell/completion.zsh ]] && source /usr/share/fzf/shell/completion.zsh

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Homebrew
if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
    export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar";
    export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew";
    fpath[1,0]="/home/linuxbrew/.linuxbrew/share/zsh/site-functions";
    export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}";
    [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
    export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}";
fi

# Syntax Highlighting
zsh-defer source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Language-specific environments
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"


# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

# Navigation and File Operations
alias t="tmux"
alias dc="cd .."
alias z="cd"
alias la="ls -a"
alias ls='eza'
alias lg='eza --icons --long --git'
alias ks='ls'  # Common typo
alias ff=fastfetch

# Editor and Development Tools
alias vim=nvim
alias v=nvim

# Git Shortcuts
alias gce='git commit -a -m "update"'
alias lz=lazygit

# Development Tools
alias yz=yazi

# Copy utilities
alias cppath=copypath
alias cpfile=copyfile


# Clear command variants 
alias claer='clear'
alias cler='clear' 
alias clcear='clear'
alias csl='clear'
alias cls='clear'
alias clar='clear'
alias clare='clear'
alias clera='clear'
alias clerar='clear'
alias ckear='clear'
alias clea='clear'
alias lear='clear'
alias clra='clear'
alias clrea='clear'
alias celar='clear'

# C++ development
alias g++='g++ -std=c++20'

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------

run_ls_if_empty() {
    if [[ -z "$BUFFER" ]]; then
        BUFFER="ls"
        zle accept-line
    else
        zle accept-line
    fi
}

# -----------------------------------------------------------------------------
# Clipboard Integration 
# -----------------------------------------------------------------------------
clipcopy() {
    cat "${1:-/dev/stdin}" | wl-copy
}

# -----------------------------------------------------------------------------
# Key Bindings
# -----------------------------------------------------------------------------
zle -N run_ls_if_empty
bindkey "^M" run_ls_if_empty

# bun completions
[ -s "/home/aryan/.bun/_bun" ] && source "/home/aryan/.bun/_bun"

# Compile the completion dump file in the background for next time
zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
  zcompile "$zcompdump"
fi
# zprof
