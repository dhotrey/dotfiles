#!/usr/bin/env zsh
# zmodload zsh/zprof
source ~/.config/zsh/zsh-defer/zsh-defer.plugin.zsh
# zmodload zsh/zprof # Commented out for speed. zprof adds overhead.

# =============================================================================
# 1. CRITICAL SPEED FLAGS
# =============================================================================
# Tell Oh-My-Zsh NOT to initialize completions (we do it faster manually below)
skip_global_compinit=1
# Stop Zsh from checking permissions on every startup
ZSH_DISABLE_COMPFIX=true

setopt PATH_DIRS
unsetopt BG_NICE

# =============================================================================
# 2. OH-MY-ZSH & PLUGINS
# =============================================================================
DISABLE_AUTO_UPDATE="true"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME='intheloop'
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

# SSH Agent: Lazy load to fix startup speed while keeping functionality
zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent identities id_rsa

plugins=(
    git
    ssh-agent
    # python
    # golang
    gitignore
    copyfile
    copypath
)
zsh-defer -c 'source $ZSH/plugins/python/python.plugin.zsh'
zsh-defer -c 'source $ZSH/plugins/golang/golang.plugin.zsh'
source "$ZSH/oh-my-zsh.sh"

# =============================================================================
# 4. ENVIRONMENT
# =============================================================================
export EDITOR="nvim"
export BUN_INSTALL="$HOME/.bun"

typeset -U path
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

# =============================================================================
# 5. EXTERNAL TOOLS (LAZY & DEFERRED)
# =============================================================================

# Zoxide: Lazy Load (Runs only when you first type 'cd' or 'z')
cd() {
    eval "$(zoxide init zsh --cmd cd)"
    cd "$@"
}

# FZF: Defer loading to after prompt is interactive
fzf_loader() {
    [[ -f /usr/share/fzf/shell/key-bindings.zsh ]] && source /usr/share/fzf/shell/key-bindings.zsh
    [[ -f /usr/share/fzf/shell/completion.zsh ]] && source /usr/share/fzf/shell/completion.zsh
    export FZF_DEFAULT_COMMAND='fd --type f'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
}
zsh-defer fzf_loader

# Syntax Highlighting: Deferred
zsh-defer source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Language Environments: Lazy Load
bun() {
    unset -f bun
    [[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
    bun "$@"
}
cargo() {
    unset -f cargo
    [[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
    cargo "$@"
}

# =============================================================================
# 6. ALIASES & FUNCTIONS
# =============================================================================
alias t="tmux"
alias dc="cd .."
unalias ls 2>/dev/null  # Remove OMZ's ls if it exists
alias ls='eza'
alias la="ls -a"
alias lg='eza --icons --long --git'
alias ks='ls'
alias ff=fastfetch
alias vim=nvim
alias v=nvim
alias gce='git commit -a -m "update"'
alias lz=lazygit
alias yz=yazi
alias cppath=copypath
alias cpfile=copyfile
alias g++='g++ -std=c++20'

# Typos
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

# Functions
run_ls_if_empty() {
    if [[ -z "$BUFFER" ]]; then
        BUFFER="ls"
        zle accept-line
    else
        zle accept-line
    fi
}

clipcopy() {
    if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        cat "${1:-/dev/stdin}" | wl-copy
    else
        cat "${1:-/dev/stdin}" | xclip -selection clipboard
    fi
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
# Keybindings
zle -N run_ls_if_empty
bindkey "^M" run_ls_if_empty
bindkey -s "^[f" "tmux-sessionizer\n"

# Linux Integration
alias code='code'
alias explorer='nautilus .'
alias open='xdg-open'

# Background cache compile
zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
  zcompile "$zcompdump" &!
fi
# zprof
