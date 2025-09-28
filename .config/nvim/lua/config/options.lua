-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ===================================================================
-- EDITOR SETTINGS
-- ===================================================================

-- Indentation and tabs
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.tabstop = 4           -- Number of spaces tabs count for
vim.opt.softtabstop = 4       -- Number of spaces for tab in insert mode
vim.opt.shiftwidth = 4        -- Size of an indent

-- Line numbers
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers

-- Search settings
vim.opt.incsearch = true      -- Show search matches as you type
vim.opt.ignorecase = true     -- Ignore case when searching
vim.opt.smartcase = true      -- Use case sensitive search if search contains uppercase

-- Display settings
vim.opt.wrap = false          -- Don't wrap lines
vim.opt.scrolloff = 8         -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8     -- Keep 8 columns left/right of cursor

-- ===================================================================
-- NEOVIDE SETTINGS (GUI)
-- ===================================================================

-- Set transparency for Neovide GUI
vim.g.neovide_transparency = 0.99

-- ===================================================================
-- FILETYPE ASSOCIATIONS
-- ===================================================================

-- Add custom filetype associations
vim.filetype.add({
    extension = {
        templ = "templ",  -- Go template files
    },
})
