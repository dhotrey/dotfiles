# Neovim Configuration Documentation

Welcome to the comprehensive documentation for this Neovim configuration! This setup provides a modern, efficient, and well-organized development environment with extensive LSP support, powerful plugins, and thoughtful keybindings.

## 📚 Table of Contents

- [Getting Started](#getting-started)
- [Configuration Structure](#configuration-structure)
- [Plugin Categories](#plugin-categories)
- [Keybindings](#keybindings)
- [Customization Guide](#customization-guide)
- [Troubleshooting](#troubleshooting)

## 🚀 Getting Started

### Prerequisites

- **Neovim 0.9.0+** (recommended: latest stable)
- **Git** for plugin management
- **Node.js** for some LSP servers and plugins
- **Python 3** with pip for Python-based tools
- A **Nerd Font** for proper icon display (optional but recommended)

### Installation

1. **Backup your existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration**:
   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

4. **Let Lazy.nvim install plugins** (this happens automatically on first launch)

5. **Install LSP servers** with Mason:
   ```
   :Mason
   ```

## 🏗️ Configuration Structure

This configuration follows a modular structure for better maintainability:

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── lua/
│   ├── config/                 # Core configuration
│   │   ├── autocmds.lua       # Auto commands
│   │   ├── keymaps.lua        # Core keybindings
│   │   ├── lazy.lua           # Plugin manager setup
│   │   └── options.lua        # Neovim options
│   └── plugins/               # Plugin configurations
│       ├── ui/                # UI and appearance
│       ├── editor/            # Editor enhancements
│       ├── coding/            # Coding assistance
│       ├── lsp/               # Language servers
│       ├── tools/             # Development tools
│       └── lang/              # Language-specific
└── docs/                      # Documentation (this folder)
```

### Core Files Explained

- **`init.lua`**: Bootstrap script that loads the plugin manager and core configuration
- **`config/options.lua`**: All Neovim settings organized by category
- **`config/keymaps.lua`**: Core keybindings that aren't plugin-specific
- **`config/autocmds.lua`**: Automatic commands for various events
- **`config/lazy.lua`**: Lazy.nvim plugin manager configuration

## 🔌 Plugin Categories

### UI Plugins (`plugins/ui/`)
- **GitHub Theme**: Professional theme matching GitHub's interface
- **Lualine**: Beautiful and informative statusline
- **Alpha**: Customizable dashboard with shortcuts

### Editor Plugins (`plugins/editor/`)
- **Telescope**: Fuzzy finder for files, buffers, and more
- **Neo-tree**: File explorer sidebar
- **Treesitter**: Advanced syntax highlighting
- **Harpoon**: Quick file navigation
- **Which-key**: Keymap hints and documentation

### Coding Plugins (`plugins/coding/`)
- **nvim-cmp**: Intelligent autocompletion
- **LuaSnip**: Snippet engine with VSCode snippet support
- **Comment.nvim**: Smart commenting with treesitter integration
- **Autoclose**: Automatic bracket and quote pairing
- **Copilot**: AI-powered code suggestions (optional)

### LSP Plugins (`plugins/lsp/`)
- **Mason**: LSP server installer and manager
- **nvim-lspconfig**: Language server configurations
- **Trouble**: Diagnostics and error management
- **null-ls**: Additional formatting and linting

### Tools (`plugins/tools/`)
- **Git Integration**: Git signs and commands
- **Debugging**: DAP (Debug Adapter Protocol) support
- **Todo Tree**: Comment annotations management
- **Wakatime**: Time tracking (optional)

### Language-Specific (`plugins/lang/`)
- **Go**: Enhanced Go development with testing support
- **Markdown**: Improved markdown editing and preview

## ⌨️ Keybindings

### Leader Key
The leader key is set to **Space** (`<Space>`).

### Core Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `<A-w>` | Normal | Window command prefix |
| `<A-h/j/k/l>` | Normal | Navigate between windows |
| `<A-p>` | Normal | Find files (Telescope) |
| `<A-f>` | Normal | Live grep (Telescope) |
| `[b` / `]b` | Normal | Previous/Next buffer |

### LSP Keybindings
| Key | Mode | Description |
|-----|------|-------------|
| `gd` | Normal | Go to definition |
| `gr` | Normal | Go to references |
| `K` | Normal | Hover documentation |
| `<leader>ca` | Normal/Visual | Code actions |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>f` | Normal | Format code |

### Trouble (Diagnostics)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>xx` | Normal | Toggle diagnostics |
| `<leader>xX` | Normal | Buffer diagnostics |
| `[q` / `]q` | Normal | Previous/Next diagnostic |

### Git
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gg` | Normal | Git status |
| `<leader>gc` | Normal | Git commits |
| `<leader>gb` | Normal | Git blame |

For a complete list of keybindings, see [KEYBINDINGS.md](KEYBINDINGS.md).

## 🎨 Customization Guide

### Adding New Plugins

1. **Choose the appropriate category** in `lua/plugins/`
2. **Create a new file** or add to existing category init file
3. **Follow the plugin template**:

```lua
-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                              Plugin Name                                   │
-- │                                                                             │
-- │ Brief description of what the plugin does and why it's useful.             │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
  "author/plugin-name",
  event = "VeryLazy", -- or other load trigger
  keys = {
    { "<leader>key", "<cmd>Command<cr>", desc = "Description" },
  },
  opts = {
    -- Plugin options
  },
  config = function(_, opts)
    -- Plugin setup
    require("plugin-name").setup(opts)
  end,
}
```

### Modifying Existing Plugins

1. **Find the plugin file** in the appropriate category
2. **Modify the opts table** or config function
3. **Restart Neovim** to apply changes

### Changing Keybindings

- **Core keybindings**: Edit `lua/config/keymaps.lua`
- **Plugin-specific**: Edit the plugin's configuration file
- **LSP keybindings**: Modify the `on_attach` function in `lua/plugins/lsp/lsp-config.lua`

### Theme Customization

Edit `lua/plugins/ui/github-theme.lua` to:
- Change color variants
- Modify transparency settings
- Adjust syntax highlighting styles

## 🔧 Troubleshooting

### Common Issues

#### Plugin Not Loading
1. Check for syntax errors in the plugin file
2. Ensure the plugin is imported in the category's `init.lua`
3. Run `:Lazy check` to verify plugin status

#### LSP Not Working
1. Check if the language server is installed: `:Mason`
2. Verify server configuration in `lua/plugins/lsp/lsp-config.lua`
3. Check LSP logs: `:LspLog`

#### Keybinding Conflicts
1. Use `:checkhealth` to identify issues
2. Check Which-key for conflicting mappings: `<leader>?`
3. Verify keymap definitions in plugin configs

#### Performance Issues
1. Check startup time: `:StartupTime` (if available)
2. Profile with `:profile start profile.log`
3. Review lazy-loading configuration in plugin specs

### Getting Help

1. **Check built-in help**: `:help <topic>`
2. **Plugin documentation**: Most plugins have detailed README files
3. **Community support**: Neovim community forums and Discord
4. **GitHub issues**: Report bugs to respective plugin repositories

## 📈 Performance Tips

- **Use lazy loading**: Most plugins are configured to load only when needed
- **Regular maintenance**: Run `:Lazy clean` and `:Lazy update` periodically
- **Profile startup**: Use tools like `nvim --startuptime startup.log` to identify slow plugins
- **Disable unused features**: Comment out or remove plugins you don't use

## 🔄 Updates and Maintenance

### Updating Plugins
```vim
:Lazy update
```

### Updating LSP Servers
```vim
:Mason update
```

### Cleaning Unused Plugins
```vim
:Lazy clean
```

## 📝 Contributing

When contributing to this configuration:

1. **Follow the established structure** and naming conventions
2. **Add comprehensive comments** explaining plugin purposes
3. **Update documentation** when adding new features
4. **Test thoroughly** before committing changes
5. **Use conventional commit messages**

---

For more detailed information, check out the other documentation files in this directory!