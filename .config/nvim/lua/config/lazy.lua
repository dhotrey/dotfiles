-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                          Lazy.nvim Plugin Manager Setup                    │
-- │                                                                             │
-- │ This file configures the lazy.nvim plugin manager with performance         │
-- │ optimizations and organized plugin loading structure.                      │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

require("lazy").setup({
  spec = {
    -- Import custom plugin configurations organized by category
    { import = "plugins.ui" },
    { import = "plugins.editor" },
    { import = "plugins.coding" },
    { import = "plugins.lsp" },
    { import = "plugins.tools" },
    { import = "plugins.lang" },
  },
  defaults = {
    -- Enable lazy loading by default for better startup performance
    lazy = true,
    -- Use latest git commits for most up-to-date features
    version = false,
  },
  -- UI customization
  ui = {
    -- Use a nerd font for fancy icons
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
  -- Fallback colorschemes in case primary theme fails to load
  install = { colorscheme = { "github_dark_default", "habamax" } },
  -- Automatically check for plugin updates
  checker = { enabled = true, notify = false },
  -- Performance optimizations
  performance = {
    rtp = {
      -- Disable unused default plugins for faster startup
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "netrwPlugin", -- we use neo-tree instead
        "matchit", -- we use treesitter for better matching
        "matchparen", -- we use treesitter for better highlighting
      },
    },
  },
})
