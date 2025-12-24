#!/usr/bin/env zsh
zmodload zsh/zprof
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
    gitignore
    copyfile
    copypath
    colored-man-pages
    command-not-found
    zsh-syntax-highlighting
)
# Load Oh-My-Zsh
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
# SSH Agent
if [ -z "$SSH_AUTH_SOCK" ]; then
   eval "$(ssh-agent -s)" > /dev/null
fi
# Restore FZF Pretty View (DNF installation paths)
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
if [[ -f "$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

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


# Clear command variants (Restored all typos)
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

go_fmt() {
    go fmt ./...
}

x() {
    if [[ $# -eq 2 ]]; then
        exercism download --track="$1" --exercise="$2"
    else
        echo "Usage: x <track> <exercise>"
        echo "Example: x zig leap"
    fi
}

run_ls_if_empty() {
    if [[ -z "$BUFFER" ]]; then
        BUFFER="ls"
        zle accept-line
    else
        zle accept-line
    fi
}

# -----------------------------------------------------------------------------
# Clipboard Integration (Fedora Fix)
# -----------------------------------------------------------------------------
clipcopy() {
    if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        cat "${1:-/dev/stdin}" | wl-copy
    else
        cat "${1:-/dev/stdin}" | xclip -selection clipboard
    fi
}

# -----------------------------------------------------------------------------
# Key Bindings
# -----------------------------------------------------------------------------
zle -N run_ls_if_empty
bindkey "^M" run_ls_if_empty
bindkey -s "^[f" "tmux-sessionizer\n"

# Linux Tools Integration (Updated from Windows paths)
alias code='code'
alias explorer='nautilus .'
alias open='xdg-open'

export PATH=$PATH:/home/aryan/.iximiuz/labctl/bin
if [[ -f "$HOME/.local/share/labctl_completion.zsh" ]]; then
    source "$HOME/.local/share/labctl_completion.zsh"
fi

# bun completions
[ -s "/home/aryan/.bun/_bun" ] && source "/home/aryan/.bun/_bun"
#
# Compile the completion dump file in the background for next time
zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
  zcompile "$zcompdump"
fi
zprof
