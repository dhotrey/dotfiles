
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME='intheloop'

# ZSH_THEME='robbyrussel'

# Uncomment the following line to use hyphen-insensitive completion.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
 DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
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
	
alias ivm=~/dotfiles/./start_nvim.sh
alias vim=nvim

alias cppath=copypath
alias cpfile=copyfile
alias yz=yazi
alias dc="cd .."
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
eval "$(ssh-agent -s)" > /dev/null
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/bob/nvim-bin
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

source /home/aryan/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# alias jj=zellij
alias lz=lazygit
alias bat=batcat
alias console='textual console'
alias claer='clear'
alias cler='clear'
alias clcear='clear'
alias csl='clear'
alias cls='clear'
alias clar='clear'
alias clare='clear'
alias clera='clear'
alias clerar='clear'
alias ckear=clear
alias clea='clear'
alias lear='clear'
alias clra='clear'
alias clrea='clear'
alias clare='clear'
alias celar='clear'
alias ks='ls'
alias ls='exa --icons'
alias lg='exa --icons --long --git'
alias cz='chezmoi'
alias cze='chezmoi edit'
alias cza='chezmoi add'
alias gce='git commit -a -m "update"'
alias gbd='go build .'
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
export PATH=$PATH:/home/.cargo/bin
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$(go env GOPATH)/bin
export EDITOR="nvim"
go_fmt() {
	go fmt ./...
}
alias format=go_fmt
function run_ls_if_empty() {
  if [[ -z "$BUFFER" ]]; then
    BUFFER="ls"
    zle accept-line
  else
    zle accept-line
  fi
}

zle -N run_ls_if_empty
bindkey "^M" run_ls_if_empty

alias la="ls -a"
. "$HOME/.cargo/env"
source ~/.secrets.sh

. "/home/aryan/.deno/env"
# bun completions
[ -s "/home/aryan/.bun/_bun" ] && source "/home/aryan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# Exercism shorthand function
function x() {
    if [ $# -eq 2 ]; then
        exercism download --track=$1 --exercise=$2
    else
        echo "Usage: x <track> <exercise>"
        echo "Example: x zig leap"
    fi
}

PATH="$PATH":"$HOME/.local/scripts/"
bindkey -s "^[f" "tmux-sessionizer\n"


# BEGIN opam configuration # THIS IS FOR OCAML INSTALLATION , INSTALL OCAML TO MAKE WORK
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/aryan/.opam/opam-init/init.zsh' ]] || source '/home/aryan/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
