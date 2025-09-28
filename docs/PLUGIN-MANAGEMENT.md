# Plugin Management Guide

This guide covers how to manage plugins in this Neovim configuration using Lazy.nvim.

## 🚀 Lazy.nvim Overview

[Lazy.nvim](https://github.com/folke/lazy.nvim) is a modern plugin manager for Neovim that provides:
- **Lazy loading**: Plugins load only when needed
- **Performance**: Fast startup times
- **UI**: Beautiful management interface
- **Dependency management**: Automatic dependency resolution
- **Health checks**: Built-in plugin health monitoring

## 📱 Plugin Manager Interface

### Opening Lazy.nvim
```vim
:Lazy
```

### Interface Commands
| Key | Action |
|-----|--------|
| `I` | Install missing plugins |
| `U` | Update plugins |
| `S` | Sync (install missing + update + clean) |
| `C` | Clean unused plugins |
| `R` | Restore plugins to lockfile state |
| `P` | Profile plugin loading times |
| `L` | Show log |
| `H` | Help |

## 🔧 Plugin Operations

### Installing Plugins

1. **Add plugin configuration** to appropriate category file
2. **Restart Neovim** or run `:Lazy reload`
3. **Install** with `:Lazy install` or just `:Lazy`

### Updating Plugins

```vim
:Lazy update           " Update all plugins
:Lazy update <plugin>  " Update specific plugin
```

### Removing Plugins

1. **Remove or comment out** the plugin configuration
2. **Clean unused plugins** with `:Lazy clean`

### Syncing Configuration

```vim
:Lazy sync  " Install missing + update + clean in one command
```

## 📂 Plugin Categories

### UI Plugins (`plugins/ui/`)

**Purpose**: Visual appearance and interface elements

**Current Plugins**:
- `github-theme`: Professional color scheme
- `lualine`: Status line with git and LSP info
- `alpha-nvim`: Start screen with shortcuts

**Adding UI Plugins**:
```lua
-- File: lua/plugins/ui/notification.lua
return {
  "rcarriga/nvim-notify",
  opts = {
    stages = "fade_in_slide_out",
    timeout = 3000,
  },
  init = function()
    vim.notify = require("notify")
  end,
}
```

### Editor Plugins (`plugins/editor/`)

**Purpose**: Core editing functionality and navigation

**Current Plugins**:
- `telescope`: Fuzzy finder for everything
- `neo-tree`: File explorer
- `treesitter`: Syntax highlighting and text objects
- `harpoon`: Quick file navigation
- `which-key`: Keymap discovery

**Adding Editor Plugins**:
```lua
-- File: lua/plugins/editor/surround.lua
return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  opts = {},
}
```

### Coding Plugins (`plugins/coding/`)

**Purpose**: Code completion, snippets, and writing assistance

**Current Plugins**:
- `nvim-cmp`: Completion engine
- `LuaSnip`: Snippet engine
- `Comment.nvim`: Smart commenting
- `autoclose.nvim`: Auto-close brackets/quotes
- `copilot`: AI code assistance

**Adding Coding Plugins**:
```lua
-- File: lua/plugins/coding/pairs.lua
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {},
}
```

### LSP Plugins (`plugins/lsp/`)

**Purpose**: Language server integration and diagnostics

**Current Plugins**:
- `mason.nvim`: LSP server installer
- `nvim-lspconfig`: LSP configuration
- `trouble.nvim`: Diagnostics interface

**Adding LSP Tools**:
```lua
-- File: lua/plugins/lsp/formatting.lua
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { "prettier" },
    },
  },
}
```

### Tools (`plugins/tools/`)

**Purpose**: Development tools and productivity enhancements

**Current Plugins**:
- Git integration
- Debugging support
- Todo management
- Time tracking

### Language-Specific (`plugins/lang/`)

**Purpose**: Language-specific enhancements and tools

**Current Plugins**:
- Go testing and development
- Markdown editing

## 🎛️ Plugin Configuration Patterns

### Basic Plugin
```lua
return {
  "author/plugin-name",
  config = true, -- Use default configuration
}
```

### Plugin with Options
```lua
return {
  "author/plugin-name",
  opts = {
    option1 = "value1",
    option2 = true,
  },
}
```

### Plugin with Custom Configuration
```lua
return {
  "author/plugin-name",
  config = function()
    require("plugin-name").setup({
      custom_option = "value",
    })
    
    -- Additional setup
    vim.keymap.set("n", "<leader>p", "<cmd>PluginCommand<cr>")
  end,
}
```

### Plugin with Dependencies
```lua
return {
  "author/main-plugin",
  dependencies = {
    "author/dependency1",
    "author/dependency2",
    {
      "author/dependency3",
      config = function()
        -- Configure dependency
      end,
    },
  },
  config = function()
    -- Configure main plugin
  end,
}
```

### Lazy Loading Strategies
```lua
return {
  "author/plugin-name",
  
  -- Load on command
  cmd = { "PluginCommand1", "PluginCommand2" },
  
  -- Load on keymap
  keys = {
    { "<leader>p", "<cmd>PluginCommand<cr>", desc = "Plugin action" },
  },
  
  -- Load on file type
  ft = { "lua", "python", "javascript" },
  
  -- Load on event
  event = "BufReadPost",
  
  -- Load after other plugins
  event = "VeryLazy",
  
  config = function()
    -- Plugin setup
  end,
}
```

## 🏷️ Version Management

### Using Specific Versions
```lua
return {
  "author/plugin-name",
  version = "1.2.3", -- Specific version
  -- or
  tag = "v1.2.3", -- Specific tag
  -- or  
  commit = "abc123", -- Specific commit
}
```

### Branch Selection
```lua
return {
  "author/plugin-name",
  branch = "develop", -- Use development branch
}
```

### Version Constraints
```lua
return {
  "author/plugin-name",
  version = "^1.0", -- Compatible with 1.x
}
```

## 🔍 Plugin Discovery

### Finding Plugins

1. **Awesome Neovim**: [GitHub repository](https://github.com/rockerBOO/awesome-neovim)
2. **Dotfyle**: [Plugin directory](https://dotfyle.com/plugins)
3. **Reddit**: r/neovim community
4. **GitHub Topics**: Search for `neovim-plugin`

### Evaluating Plugins

Before adding a plugin, consider:
- **Maintenance**: Is it actively maintained?
- **Documentation**: Is it well documented?
- **Performance**: Will it slow down startup?
- **Dependencies**: What does it require?
- **Alternatives**: Are there better options?

## 🧪 Testing New Plugins

### Safe Testing Approach

1. **Create a test branch**:
   ```bash
   git checkout -b test-new-plugin
   ```

2. **Add plugin configuration**

3. **Test thoroughly**:
   ```vim
   :Lazy install
   :checkhealth
   ```

4. **If satisfied, merge**:
   ```bash
   git checkout main
   git merge test-new-plugin
   ```

### Temporary Plugin Testing
```lua
-- Add to any plugin file for temporary testing
return {
  "author/test-plugin",
  enabled = false, -- Disable easily
  -- or
  cond = false, -- Conditional disable
  config = function()
    -- Test configuration
  end,
}
```

## 🔒 Lockfile Management

### Understanding lazy-lock.json

The lockfile ensures reproducible plugin versions:
- **Commit to version control**: Include in git
- **Updates**: Automatically updated when plugins change
- **Restoration**: Use `:Lazy restore` to revert to lockfile state

### Lockfile Commands
```vim
:Lazy restore    " Restore to lockfile versions
:Lazy lock       " Update lockfile with current versions
```

## 🚨 Troubleshooting

### Common Issues

#### Plugin Not Loading
1. Check syntax in plugin file
2. Verify category import in `init.lua`
3. Check lazy loading conditions
4. Run `:Lazy check`

#### Conflicts Between Plugins
1. Check keybinding conflicts with `:verbose map <key>`
2. Use `:checkhealth` to identify issues
3. Disable one plugin temporarily to isolate

#### Performance Issues
1. Profile with `:Lazy profile`
2. Check startup time: `nvim --startuptime startup.log`
3. Review lazy loading configuration

#### Missing Dependencies
1. Check error messages in `:messages`
2. Install missing external dependencies
3. Update plugin specifications

### Debug Commands
```vim
:Lazy check      " Check plugin status
:Lazy health     " Plugin health check  
:Lazy profile    " Profile plugin loading
:Lazy log        " View detailed logs
:messages        " View error messages
:checkhealth     " System health check
```

## 📈 Performance Optimization

### Startup Time Optimization

1. **Use lazy loading extensively**:
   ```lua
   event = "VeryLazy"  -- Load after startup
   cmd = "Command"     -- Load on command
   ft = "filetype"     -- Load on filetype
   ```

2. **Minimize eager plugins**:
   ```lua
   lazy = false  -- Only use when necessary
   ```

3. **Profile regularly**:
   ```vim
   :Lazy profile
   ```

### Memory Usage
- Monitor with `:lua print(collectgarbage("count"))`
- Disable unused features in plugins
- Use `opts` instead of `config` for simple setups

## 🔄 Maintenance Routine

### Weekly Maintenance
```vim
:Lazy update     " Update plugins
:Mason update    " Update LSP servers
:checkhealth     " Check system health
```

### Monthly Maintenance
```vim
:Lazy clean      " Remove unused plugins
:Lazy profile    " Check performance
```

Review and update:
- Plugin configurations
- Keybindings
- Documentation

### Backup Strategy
1. **Git commit regularly**
2. **Test updates in branches**
3. **Keep notes of working configurations**

## 📚 Advanced Plugin Management

### Custom Plugin Loading
```lua
-- File: lua/plugins/custom/init.lua
return {
  -- Local plugin development
  {
    dir = "~/projects/my-plugin",
    name = "my-plugin",
    config = function()
      require("my-plugin").setup()
    end,
  },
  
  -- Fork with modifications
  {
    "myusername/forked-plugin",
    branch = "my-modifications",
    config = function()
      -- Custom configuration
    end,
  },
}
```

### Plugin Priorities
```lua
return {
  "colorscheme/plugin",
  priority = 1000, -- Load first
  
  "important/plugin", 
  priority = 900,   -- Load early
  
  "normal/plugin",  -- Default priority: 50
}
```

### Conditional Plugin Loading
```lua
return {
  "gui/plugin",
  cond = function()
    return vim.g.neovide or vim.g.started_by_firenvim
  end,
  
  "work/plugin",
  enabled = function()
    return os.getenv("WORK_MODE") == "1"
  end,
}
```

Remember: Good plugin management is key to maintaining a fast, stable, and enjoyable Neovim experience!