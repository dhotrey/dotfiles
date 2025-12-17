#!/usr/bin/env zsh
# zmodload zsh/zprof
# =============================================================================
# ZSH Configuration
# =============================================================================

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
    python
    golang
    fzf
    gitignore
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

 path=(
    "$HOME/go/bin"
    "${path[@]}"
)

export PATH

# -----------------------------------------------------------------------------
# External Tools Integration
# -----------------------------------------------------------------------------
# Zoxide
eval "$(zoxide init zsh --cmd cd)"
# SSH Agent
if [ -z "$SSH_AUTH_SOCK" ]; then
   eval "$(ssh-agent -s)" > /dev/null
fi

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
# Clipboard Integration (WSL Fix)
# -----------------------------------------------------------------------------
# Override clipcopy to explicitly use the Windows clipboard tool
clipcopy() {
    cat "${1:-/dev/stdin}" | /mnt/c/Windows/System32/clip.exe
}

# -----------------------------------------------------------------------------
# Key Bindings
# -----------------------------------------------------------------------------
zle -N run_ls_if_empty
bindkey "^M" run_ls_if_empty
bindkey -s "^[f" "tmux-sessionizer\n"

# Windows Tools Integration
# (Adjust the username 'aryan' if your Windows user folder is named differently)
alias code='/mnt/c/Users/aryan/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code'
alias explorer='/mnt/c/Windows/explorer.exe'
alias cmd='/mnt/c/Windows/System32/cmd.exe'
alias powershell='/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe'

export PATH=$PATH:/home/aryan/.iximiuz/labctl/bin
if [[ -f "$HOME/.local/share/labctl_completion.zsh" ]]; then
    source "$HOME/.local/share/labctl_completion.zsh"
# source <(labctl completion zsh)
fi
# zprof

# bun completions
[ -s "/home/aryan/.bun/_bun" ] && source "/home/aryan/.bun/_bun"
