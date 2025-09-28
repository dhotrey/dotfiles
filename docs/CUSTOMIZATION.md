# Customization Guide

This guide explains how to customize and extend your Neovim configuration effectively.

## 🎨 General Customization Philosophy

This configuration is designed to be:
- **Modular**: Each feature is organized in separate files
- **Documented**: Every plugin and setting is clearly explained
- **Extensible**: Easy to add new functionality without breaking existing features
- **Modern**: Uses latest Neovim APIs and best practices

## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point - rarely needs changes
├── lua/
│   ├── config/                 # Core configuration
│   │   ├── autocmds.lua       # Auto commands
│   │   ├── keymaps.lua        # Global keybindings
│   │   ├── lazy.lua           # Plugin manager setup
│   │   └── options.lua        # Neovim options
│   └── plugins/               # Plugin configurations
│       ├── ui/                # Interface plugins
│       ├── editor/            # Editor enhancements
│       ├── coding/            # Development assistance
│       ├── lsp/               # Language servers
│       ├── tools/             # Development tools
│       └── lang/              # Language-specific
```

## 🔧 Common Customizations

### Changing the Theme

1. **Browse available themes**:
   - Check the [GitHub themes repository](https://github.com/projekt0n/github-nvim-theme)
   - Available variants: `github_dark`, `github_light`, `github_dark_colorblind`, etc.

2. **Edit the theme file**:
   ```lua
   -- File: lua/plugins/ui/github-theme.lua
   config = function(_, opts)
     require("github-theme").setup(opts)
     vim.cmd.colorscheme("github_light") -- Change this line
   end,
   ```

3. **Or switch to a different theme entirely**:
   ```lua
   -- Replace the entire github-theme.lua content with:
   return {
     "folke/tokyonight.nvim",
     lazy = false,
     priority = 1000,
     config = function()
       vim.cmd.colorscheme("tokyonight-night")
     end,
   }
   ```

### Modifying Keybindings

#### Global Keybindings
Edit `lua/config/keymaps.lua`:

```lua
-- Add your custom keybindings
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
vim.keymap.set("n", "<C-s>", "<cmd>write<cr>", { desc = "Save file" })
```

#### Plugin-Specific Keybindings
Edit the plugin's configuration file:

```lua
-- In lua/plugins/editor/telescope.lua
keys = {
  -- Add your custom telescope keybindings
  { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Find Marks" },
  { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Jump List" },
},
```

#### LSP Keybindings
Edit `lua/plugins/lsp/lsp-config.lua` in the `on_attach` function:

```lua
local function on_attach(client, bufnr)
  local function map(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  -- Add your LSP keybindings here
  map("<leader>cf", vim.lsp.buf.format, "Format")
  map("<leader>ci", vim.lsp.buf.implementation, "Implementation")
end
```

### Adjusting Options

Edit `lua/config/options.lua`:

```lua
-- Add your custom options
vim.opt.colorcolumn = "80"        -- Show column guide
vim.opt.spell = true              -- Enable spell checking
vim.opt.spelllang = "en_us"       -- Set spell language
vim.opt.conceallevel = 2          -- Conceal level for markdown
```

### Adding Auto Commands

Edit `lua/config/autocmds.lua`:

```lua
-- Example: Auto-format on save for specific file types
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("format_on_save"),
  pattern = { "*.lua", "*.go", "*.rs" },
  callback = function()
    vim.lsp.buf.format()
  end,
})
```

## 🔌 Adding New Plugins

### Step 1: Choose the Right Category

- **UI**: Themes, statuslines, dashboards, notifications
- **Editor**: File explorers, fuzzy finders, syntax highlighting
- **Coding**: Completion, snippets, commenting, formatting
- **LSP**: Language servers, diagnostics, references
- **Tools**: Git, debugging, testing, productivity tools
- **Lang**: Language-specific enhancements

### Step 2: Create the Plugin File

Create a new file in the appropriate category:

```lua
-- File: lua/plugins/editor/my-new-plugin.lua

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                              Plugin Name                                   │
-- │                                                                             │
-- │ Brief description of what this plugin does and why it's useful.            │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
  "author/plugin-name",
  event = "VeryLazy", -- When to load the plugin
  dependencies = { "required/dependency" }, -- Optional dependencies
  keys = {
    { "<leader>key", "<cmd>Command<cr>", desc = "Description" },
  },
  opts = {
    -- Plugin configuration options
    option1 = "value1",
    option2 = true,
  },
  config = function(_, opts)
    -- Plugin setup
    require("plugin-name").setup(opts)
    
    -- Additional configuration if needed
  end,
}
```

### Step 3: Add to Category Index

Edit the category's `init.lua` file:

```lua
-- File: lua/plugins/editor/init.lua
return {
  require("plugins.editor.telescope"),
  require("plugins.editor.neo-tree"),
  require("plugins.editor.my-new-plugin"), -- Add this line
  -- ... other plugins
}
```

## 🛠️ Advanced Customizations

### Custom Plugin Configuration Patterns

#### Conditional Loading
```lua
return {
  "author/plugin-name",
  enabled = function()
    return vim.fn.executable("required-binary") == 1
  end,
  cond = function()
    return vim.fn.has("gui_running") == 1
  end,
}
```

#### Multiple Configurations
```lua
return {
  {
    "author/plugin-name",
    config = function()
      -- First configuration
    end,
  },
  {
    "author/plugin-name",
    name = "plugin-variant",
    config = function()
      -- Alternative configuration
    end,
  },
}
```

#### Language-Specific Loading
```lua
return {
  "author/go-plugin",
  ft = { "go", "gomod" }, -- Only load for Go files
  config = function()
    -- Go-specific setup
  end,
}
```

### Creating Custom Commands

Add to any plugin file or `lua/config/autocmds.lua`:

```lua
-- Create custom commands
vim.api.nvim_create_user_command("FormatJson", function()
  vim.cmd("%!jq .")
end, { desc = "Format JSON with jq" })

vim.api.nvim_create_user_command("ReloadConfig", function()
  -- Clear module cache
  for name, _ in pairs(package.loaded) do
    if name:match("^config") or name:match("^plugins") then
      package.loaded[name] = nil
    end
  end
  
  -- Reload configuration
  dofile(vim.env.MYVIMRC)
  vim.notify("Configuration reloaded!", vim.log.levels.INFO)
end, { desc = "Reload Neovim configuration" })
```

### Custom Functions and Utilities

Create `lua/utils.lua`:

```lua
local M = {}

-- Utility to check if a command exists
function M.command_exists(cmd)
  return vim.fn.executable(cmd) == 1
end

-- Utility to safely require a module
function M.safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify("Failed to load " .. module, vim.log.levels.ERROR)
    return nil
  end
  return result
end

-- Utility to get the current git branch
function M.get_git_branch()
  local handle = io.popen("git branch --show-current 2>/dev/null")
  if handle then
    local branch = handle:read("*a"):gsub("%s+", "")
    handle:close()
    return branch ~= "" and branch or nil
  end
  return nil
end

return M
```

Then use in other files:
```lua
local utils = require("utils")

if utils.command_exists("rg") then
  -- Use ripgrep
else
  -- Fallback to grep
end
```

## 🎯 Language-Specific Customizations

### Adding a New Language Server

1. **Add to Mason ensure_installed** in `lua/plugins/lsp/lsp-config.lua`:
```lua
local servers = {
  -- ... existing servers
  tailwindcss = {
    filetypes = { "html", "css", "javascript", "typescript", "vue" },
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            "tw`([^`]*)",
            "tw=\"([^\"]*)",
            "tw={\"([^\"}]*)",
            "tw\\.\\w+`([^`]*)",
            "tw\\(.*?\\)`([^`]*)",
          },
        },
      },
    },
  },
}
```

2. **Configure file type detection** in `lua/config/options.lua`:
```lua
vim.filetype.add({
  extension = {
    postcss = "css",
    pcss = "css",
  },
})
```

### Adding Language-Specific Plugins

Create `lua/plugins/lang/web.lua`:
```lua
return {
  -- Emmet for HTML/CSS expansion
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "typescript", "vue" },
    init = function()
      vim.g.user_emmet_leader_key = "<C-e>"
    end,
  },
  
  -- Tailwind CSS IntelliSense
  {
    "tailwindlabs/tailwindcss-intellisense",
    ft = { "html", "css", "javascript", "typescript", "vue" },
  },
}
```

## 🚀 Performance Optimization

### Lazy Loading Best Practices

```lua
return {
  "expensive/plugin",
  -- Load only when needed
  cmd = { "ExpensiveCommand" },
  keys = { "<leader>ep" },
  ft = { "specific-filetype" },
  event = "VeryLazy", -- Load after startup
  
  -- Optimize loading
  init = function()
    -- Quick setup that runs immediately
    vim.g.plugin_setting = "value"
  end,
  
  config = function()
    -- Expensive setup that runs when plugin loads
    require("expensive-plugin").setup({
      -- configuration
    })
  end,
}
```

### Startup Time Optimization

1. **Profile startup time**:
   ```bash
   nvim --startuptime startup.log
   ```

2. **Use event-based loading**:
   ```lua
   event = { "BufReadPre", "BufNewFile" }, -- File-related
   event = "VeryLazy", -- After startup
   event = "InsertEnter", -- When entering insert mode
   ```

3. **Minimize eager plugins**:
   ```lua
   lazy = false, -- Only use when absolutely necessary
   priority = 1000, -- Only for colorschemes
   ```

## 🐛 Debugging Configuration Issues

### Common Debugging Commands

```vim
:checkhealth        " Check overall health
:Lazy              " Plugin manager status
:Mason             " LSP server status
:LspInfo           " LSP client information
:Telescope health  " Telescope status
:messages          " View error messages
```

### Debugging Lua Code

Add debug prints:
```lua
vim.notify("Debug: " .. vim.inspect(variable), vim.log.levels.INFO)
```

Check if modules load correctly:
```lua
local ok, module = pcall(require, "module-name")
if not ok then
  vim.notify("Failed to load module: " .. module, vim.log.levels.ERROR)
  return
end
```

### Configuration Validation

Create `lua/config/validate.lua`:
```lua
local M = {}

function M.validate_config()
  local errors = {}
  
  -- Check required executables
  local required_cmds = { "git", "rg", "fd" }
  for _, cmd in ipairs(required_cmds) do
    if vim.fn.executable(cmd) == 0 then
      table.insert(errors, "Missing required command: " .. cmd)
    end
  end
  
  -- Check plugin health
  local lazy_ok, lazy = pcall(require, "lazy")
  if not lazy_ok then
    table.insert(errors, "Lazy.nvim not loaded")
  end
  
  if #errors > 0 then
    vim.notify("Configuration issues:\n" .. table.concat(errors, "\n"), vim.log.levels.WARN)
  else
    vim.notify("Configuration validated successfully!", vim.log.levels.INFO)
  end
end

return M
```

## 📚 Additional Resources

- **Neovim Documentation**: `:help` and [neovim.io](https://neovim.io/)
- **Lazy.nvim**: [Plugin manager documentation](https://lazy.folke.io/)
- **Which-key**: Use `<leader>?` to discover available keybindings
- **Telescope**: Use `:Telescope help_tags` to search help
- **LSP**: `:help lsp` for comprehensive LSP information

Remember: Always test your changes in a separate branch or backup your configuration before making major modifications!