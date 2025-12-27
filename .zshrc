#!/usr/bin/env zsh
# zmodload zsh/zprof
# Optimized Zsh config with Starship (~60ms startup)

# =============================================================================
# SHELL OPTIONS
# =============================================================================
setopt PATH_DIRS
unsetopt BG_NICE

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS  # Don't save duplicates
setopt HIST_FIND_NO_DUPS     # Don't show duplicates in search
setopt HIST_IGNORE_SPACE     # Don't save commands starting with space
setopt SHARE_HISTORY         # Share history across all sessions
setopt APPEND_HISTORY        # Append to history file
setopt INC_APPEND_HISTORY    # Write to history immediately

# =============================================================================
# PERFORMANCE: Load zsh-defer early for async loading
# =============================================================================
source ~/.config/zsh/zsh-defer/zsh-defer.plugin.zsh

# =============================================================================
# SHELL OPTIONS
# =============================================================================
setopt PATH_DIRS      # Perform path search on commands with slashes
unsetopt BG_NICE      # Don't nice background jobs

# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================
export EDITOR="nvim"
export BUN_INSTALL="$HOME/.bun"

# Homebrew: Disable auto-update for speed
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1

# PATH configuration
typeset -U path  # Keep unique entries only
path=(
    "$HOME/.local/bin"
    "$HOME/.local/share/bob/nvim-bin"
    "$HOME/.local/scripts"
    "$GOROOT/bin"
    "$BUN_INSTALL/bin" 
    "/home/linuxbrew/.linuxbrew/bin"
    "$HOME/.cargo/bin"
    $path  # Existing PATH entries
)
export PATH

# =============================================================================
# PROMPT: Starship (fast, async rendering)
# =============================================================================
eval "$(starship init zsh)"
fpath=(/home/linuxbrew/.linuxbrew/share/zsh/site-functions $fpath)
# =============================================================================
# COMPLETIONS: Initialize once with caching
# =============================================================================
autoload -Uz compinit

# Use cached completions if less than 24 hours old, otherwise regenerate
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit -C  # Use cache, skip security check
else
  compinit -i  # Regenerate and check
fi

# Compile completion dump in background for faster future loads
zsh-defer -c '
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
'

# =============================================================================
# GIT ALIASES (replaces OMZ git plugin)
# =============================================================================
# Basic operations
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcam='git commit -a -m'
alias gcm='git commit -m'
alias gce='git commit -a -m "update"'  # Your existing alias

# Branch operations
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gco='git checkout'
alias gcb='git checkout -b'

# Status and logs
alias gst='git status'
alias gss='git status -s'
alias gl='git pull'
alias gp='git push'
alias glg='git log --stat'
alias glgg='git log --graph --oneline --decorate --all'

# Diff and show
alias gd='git diff'
alias gdca='git diff --cached'
alias gsh='git show'

# Stash
alias gsta='git stash'
alias gstaa='git stash apply'
alias gstp='git stash pop'

# Remote
alias gr='git remote'
alias grv='git remote -v'

# Other useful aliases
alias gclean='git clean -fd'
alias grh='git reset HEAD'
alias grhh='git reset --hard HEAD'

# =============================================================================
# BASIC ALIASES
# =============================================================================
# Navigation & listing
alias t="tmux"
alias dc="cd .."
alias ls='eza'
alias la='eza -a'
alias ll='eza -l'
alias lg='eza --icons --long --git'
alias ks='ls'  # Typo alias

# Editors
alias vim='nvim'
alias v='nvim'

# Tools
alias ff='fastfetch'
alias lz='lazygit'
alias yz='yazi'

# System
alias explorer='nautilus .'
alias open='xdg-open'
alias dark-mode="lookandfeeltool -a org.kde.breezedark.desktop"
alias light-mode="lookandfeeltool -a org.kde.breeze.desktop"

# C++ compilation with modern standard
alias g++='g++ -std=c++20'

# Common typos for 'clear'
alias claer='clear' cler='clear' clcear='clear' csl='clear' cls='clear'
alias clar='clear' clare='clear' clera='clear' clerar='clear' ckear='clear'
alias clea='clear' lear='clear' clra='clear' clrea='clear' celar='clear'

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

# Copy file path to clipboard
copypath() {
    local file="${1:-.}"  # Default to current directory
    [[ $file = /* ]] || file="$PWD/$file"  # Make absolute path
    print -n "${file:a}" | clipcopy
}
alias cppath='copypath'

# Copy file contents to clipboard
copyfile() {
    emulate -L zsh
    clipcopy < "${1:-/dev/stdin}"
}
alias cpfile='copyfile'

# Clipboard helper (Wayland/X11 compatible)
clipcopy() {
    if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        cat "${1:-/dev/stdin}" | wl-copy
    else
        cat "${1:-/dev/stdin}" | xclip -selection clipboard
    fi
}

# Yazi: CD to directory on exit
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# Auto-run ls on empty Enter key
run_ls_if_empty() {
    if [[ -z "$BUFFER" ]]; then
        BUFFER="ls"
        zle accept-line
    else
        zle accept-line
    fi
}

# =============================================================================
# KEY BINDINGS
# =============================================================================
zle -N run_ls_if_empty
bindkey "^M" run_ls_if_empty           # Enter key
bindkey -s "^[f" "tmux-sessionizer\n"  # Alt+F for tmux sessionizer

# =============================================================================
# DEFERRED LOADS (after prompt appears, async)
# =============================================================================

zsh-defer source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Zoxide: Smart directory jumper (lazy load on first use)
cd() {
    unfunction cd
    eval "$(zoxide init zsh --cmd cd)"
    cd "$@"
}

# FZF: Fuzzy finder integration
zsh-defer -c '
    if [[ -f /usr/share/fzf/shell/key-bindings.zsh ]]; then
        source /usr/share/fzf/shell/key-bindings.zsh
        source /usr/share/fzf/shell/completion.zsh
        export FZF_DEFAULT_COMMAND="fd --type f"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
'

# Syntax highlighting (load last for best compatibility)
zsh-defer source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Language environment managers (lazy load on first use)
bun() {
    unfunction bun
    [[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
    bun "$@"
}

cargo() {
    unfunction cargo
    [[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
    cargo "$@"
}

# =============================================================================
# END OF CONFIG
# =============================================================================
# zprof
