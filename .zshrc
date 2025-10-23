#!/usr/bin/env zsh
# =============================================================================
# ZSH Configuration
# =============================================================================

# -----------------------------------------------------------------------------
# Oh-My-Zsh Configuration
# -----------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME='intheloop'

# Oh-My-Zsh Settings
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

# Oh-My-Zsh Plugins
plugins=(
    git
    python
    golang
    fzf
    gitignore
    z
    copyfile
    copypath
    colored-man-pages
    command-not-found
)
# Load Oh-My-Zsh
source "$ZSH/oh-my-zsh.sh"

# -----------------------------------------------------------------------------
# Environment Variables
# -----------------------------------------------------------------------------
export EDITOR="nvim"
export GOPATH="$HOME/go"
export GOROOT="/usr/local/go"
export BUN_INSTALL="$HOME/.bun"

# -----------------------------------------------------------------------------
# PATH Configuration
# -----------------------------------------------------------------------------
# Build PATH incrementally to avoid duplicates
typeset -U path  # Keep unique entries in path array
path=(
    "$HOME/.local/bin"
    "$HOME/.local/share/bob/nvim-bin"
    "$HOME/.local/scripts"
    "/usr/local/go/bin"
    "$GOROOT/bin"
    "$BUN_INSTALL/bin" 
    "/home/linuxbrew/.linuxbrew/bin"
    "$HOME/.cargo/bin"
    "${path[@]}"
)

# Add Go binary path (dynamic)
if command -v go >/dev/null 2>&1; then
    gopath_bin="$(go env GOPATH)/bin"
    path=("$gopath_bin" "${path[@]}")
fi

export PATH

# -----------------------------------------------------------------------------
# External Tools Integration
# -----------------------------------------------------------------------------
# SSH Agent
eval "$(ssh-agent -s)" > /dev/null

# Homebrew
if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Syntax Highlighting - Use more flexible path detection
if [[ -f "$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Language-specific environments
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
[[ -f "$HOME/.deno/env" ]] && source "$HOME/.deno/env"
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# Opam (OCaml) - with proper path detection
[[ -r "$HOME/.opam/opam-init/init.zsh" ]] && source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null

# # Atuin (command history)
# [[ -f "$HOME/.atuin/bin/env" ]] && source "$HOME/.atuin/bin/env"
# command -v atuin >/dev/null 2>&1 && eval "$(atuin init zsh)"

# User secrets (optional)
[[ -f "$HOME/.secrets.sh" ]] && source "$HOME/.secrets.sh"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

# Navigation and File Operations
alias dc="cd .."
alias la="ls -a"
alias ls='exa --icons'
alias lg='exa --icons --long --git'
alias ks='ls'  # Common typo

# Editor and Development Tools
alias vim=nvim
alias ivm='$HOME/dotfiles/./start_nvim.sh'

# Git Shortcuts
alias gce='git commit -a -m "update"'
alias lz=lazygit

# Development Tools
alias bat=batcat
alias console='textual console'
alias yz=yazi

# Copy utilities
alias cppath=copypath
alias cpfile=copyfile

# Package Managers and Tools
alias cz='chezmoi'
alias cze='chezmoi edit'
alias cza='chezmoi add'

# Go Development
alias gbd='go build .'
alias format=go_fmt

# Clear command variants (common typos)
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

# Go formatter function
go_fmt() {
    go fmt ./...
}

# Exercism shorthand function
x() {
    if [[ $# -eq 2 ]]; then
        exercism download --track="$1" --exercise="$2"
    else
        echo "Usage: x <track> <exercise>"
        echo "Example: x zig leap"
    fi
}

# Auto-run ls when pressing enter on empty command line
run_ls_if_empty() {
    if [[ -z "$BUFFER" ]]; then
        BUFFER="ls"
        zle accept-line
    else
        zle accept-line
    fi
}

# -----------------------------------------------------------------------------
# Key Bindings
# -----------------------------------------------------------------------------
zle -N run_ls_if_empty
bindkey "^M" run_ls_if_empty
bindkey -s "^[f" "tmux-sessionizer\n"
