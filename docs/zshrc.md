# ZSH Configuration Documentation

This document explains the structure and functionality of the `.zshrc` configuration file, which has been organized for better maintainability and modern shell practices.

## Overview

The `.zshrc` file is structured into logical sections with clear separation of concerns. Each section handles a specific aspect of the shell configuration, making it easy to understand, modify, and maintain.

## File Structure

```
├── Oh-My-Zsh Configuration
├── Environment Variables
├── PATH Configuration
├── External Tools Integration
├── Aliases
├── Functions
└── Key Bindings
```

## Sections Explained

### 1. Oh-My-Zsh Configuration

```bash
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME='intheloop'
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
```

**Purpose**: Configures the Oh-My-Zsh framework that provides themes, plugins, and enhanced functionality.

**Key Settings**:
- `ZSH_THEME='intheloop'`: Sets the prompt theme
- `DISABLE_AUTO_TITLE="true"`: Prevents automatic terminal title changes
- `COMPLETION_WAITING_DOTS="true"`: Shows dots while waiting for completion

**Plugins**:
- `git`: Git integration and aliases
- `python`: Python development enhancements
- `golang`: Go development tools
- `fzf`: Fuzzy finder integration
- `gitignore`: Gitignore file management
- `z`: Smart directory jumping
- `copyfile/copypath`: File/path copying utilities
- `colored-man-pages`: Colorized manual pages
- `command-not-found`: Suggests packages for missing commands

### 2. Environment Variables

```bash
export EDITOR="nvim"
export GOPATH="$HOME/go"
export GOROOT="/usr/local/go"
export BUN_INSTALL="$HOME/.bun"
```

**Purpose**: Sets up global environment variables used by various tools and applications.

**Variables**:
- `EDITOR`: Default text editor (Neovim)
- `GOPATH`: Go workspace directory
- `GOROOT`: Go installation directory
- `BUN_INSTALL`: Bun JavaScript runtime installation directory

### 3. PATH Configuration

```bash
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
```

**Purpose**: Manages the system PATH efficiently with automatic deduplication.

**Features**:
- `typeset -U path`: Ensures unique entries (no duplicates)
- Organized list of directories in priority order
- Dynamic Go path detection for development tools
- Support for various package managers (Homebrew, Cargo, Bun)

**Directory Purposes**:
- `$HOME/.local/bin`: User-installed binaries
- `$HOME/.local/share/bob/nvim-bin`: Neovim version manager binaries
- `$HOME/.local/scripts`: Custom user scripts
- `/usr/local/go/bin`: Go compiler and tools
- `$HOME/.cargo/bin`: Rust/Cargo installed binaries
- `/home/linuxbrew/.linuxbrew/bin`: Homebrew on Linux binaries

### 4. External Tools Integration

This section handles integration with various development tools and environments:

```bash
# SSH Agent
eval "$(ssh-agent -s)" > /dev/null

# Homebrew
if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Language-specific environments
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
[[ -f "$HOME/.deno/env" ]] && source "$HOME/.deno/env"
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
```

**Integrated Tools**:
- **SSH Agent**: Manages SSH keys for authentication
- **Homebrew**: Package manager for Linux/macOS
- **Syntax Highlighting**: Enhanced command-line syntax highlighting
- **Rust/Cargo**: Rust development environment
- **Deno**: Modern JavaScript/TypeScript runtime
- **Bun**: Fast JavaScript runtime and package manager
- **OCaml/Opam**: OCaml development environment
- **Atuin**: Enhanced shell history with sync capabilities

**Error Handling**: All integrations use conditional loading - they only activate if the tool is installed, preventing errors on systems where tools are missing.

### 5. Aliases

Aliases are organized by functionality for easy navigation:

#### Navigation & File Operations
```bash
alias dc="cd .."          # Quick parent directory navigation
alias la="ls -a"          # List all files including hidden
alias ls='exa --icons'    # Enhanced ls with icons
alias lg='exa --icons --long --git'  # Long format with git status
alias ks='ls'             # Common typo correction
```

#### Editor & Development Tools
```bash
alias vim=nvim                              # Use Neovim instead of Vim
alias ivm='$HOME/dotfiles/./start_nvim.sh'  # Custom Neovim launcher
```

#### Git Shortcuts
```bash
alias gce='git commit -a -m "update"'  # Quick commit with generic message
alias lz=lazygit                       # Launch LazyGit TUI
```

#### Development Tools
```bash
alias bat=batcat          # Better cat with syntax highlighting
alias console='textual console'  # Textual development console
alias yz=yazi             # File manager
```

#### Package Managers & Tools
```bash
alias cz='chezmoi'        # Dotfiles manager
alias cze='chezmoi edit'  # Edit dotfiles
alias cza='chezmoi add'   # Add files to dotfiles
```

#### Go Development
```bash
alias gbd='go build .'    # Build current Go project
alias format=go_fmt       # Format Go code
```

#### Clear Command Variants
A comprehensive set of aliases to handle common typos when typing "clear":
```bash
alias claer='clear'   alias cler='clear'    alias clcear='clear'
alias csl='clear'     alias cls='clear'     alias clar='clear'
# ... and many more
```

### 6. Functions

Custom functions that extend shell functionality:

#### `go_fmt()`
```bash
go_fmt() {
    go fmt ./...
}
```
Formats all Go files in the current directory and subdirectories.

#### `x()`
```bash
x() {
    if [[ $# -eq 2 ]]; then
        exercism download --track="$1" --exercise="$2"
    else
        echo "Usage: x <track> <exercise>"
        echo "Example: x zig leap"
    fi
}
```
Shorthand for downloading Exercism coding exercises.

#### `run_ls_if_empty()`
```bash
run_ls_if_empty() {
    if [[ -z "$BUFFER" ]]; then
        BUFFER="ls"
        zle accept-line
    else
        zle accept-line
    fi
}
```
Automatically runs `ls` when pressing Enter on an empty command line.

### 7. Key Bindings

Custom keyboard shortcuts for enhanced productivity:

```bash
bindkey "^M" run_ls_if_empty      # Enter key behavior
bindkey -s "^[f" "tmux-sessionizer\n"  # Alt+F for tmux session management
```

**Key Bindings**:
- **Enter**: Runs `ls` if command line is empty, otherwise executes command
- **Alt+F**: Launches tmux-sessionizer for quick project switching

## Usage Tips

### Adding New Aliases
Add new aliases in the appropriate section:
- Navigation/file operations → Navigation & File Operations
- Development tools → Development Tools
- Git commands → Git Shortcuts

### Adding New PATH Directories
Add new directories to the `path` array in the PATH Configuration section:
```bash
path=(
    # existing directories...
    "/new/directory/bin"
    "${path[@]}"
)
```

### Adding New Tool Integration
Add new tool integration in the External Tools Integration section:
```bash
# New Tool
if command -v newtool >/dev/null 2>&1; then
    eval "$(newtool init zsh)"
fi
```

### Customizing Oh-My-Zsh
Modify the plugins array to add/remove Oh-My-Zsh plugins:
```bash
plugins=(
    git
    python
    # add new plugin here
    newplugin
)
```

## Troubleshooting

### Common Issues

1. **PATH not working**: Ensure directories exist and have proper permissions
2. **Oh-My-Zsh not loading**: Verify Oh-My-Zsh is installed in `$HOME/.oh-my-zsh`
3. **Aliases not working**: Check for typos and ensure proper quoting
4. **Functions not available**: Verify function syntax and reload configuration

### Debugging

To debug configuration issues:
```bash
# Reload configuration
source ~/.zshrc

# Check PATH
echo $PATH

# List all aliases
alias

# Check if function exists
type function_name
```

## Performance Considerations

- **Plugin Loading**: Too many Oh-My-Zsh plugins can slow startup
- **PATH Length**: Excessive PATH entries can impact command lookup
- **External Tool Integration**: Heavy tools may increase shell startup time

## Security Notes

- SSH agent is started automatically for key management
- External tool integrations use conditional loading for security
- All file paths use proper variable expansion to prevent injection attacks
- Secrets are loaded from a separate `~/.secrets.sh` file (if exists)

## Maintenance

Regular maintenance tasks:
1. Review and remove unused aliases
2. Update Oh-My-Zsh and plugins periodically
3. Clean up PATH entries for uninstalled tools
4. Monitor shell startup performance
5. Keep external tool integrations up to date