-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                             Core Vim Options                               │
-- │                                                                             │
-- │ This file contains all the core Neovim options and settings.               │
-- │ Options are organized by category for better maintainability.              │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Set leader key early so plugins can use it
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                                UI/Display                                   │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Always show sign column to prevent text shifting
vim.opt.signcolumn = "yes"

-- Show current mode in command line
vim.opt.showmode = false

-- Enable 24-bit RGB colors
vim.opt.termguicolors = true

-- Better completion menu
vim.opt.completeopt = "menu,menuone,noselect"

-- Show matching brackets
vim.opt.showmatch = true

-- Highlight current line
vim.opt.cursorline = true

-- Keep cursor centered when scrolling
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                            Text Editing                                     │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Indentation settings
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 4 -- Number of spaces a tab character represents
vim.opt.softtabstop = 4 -- Number of spaces for tab key
vim.opt.shiftwidth = 4 -- Number of spaces for auto-indent
vim.opt.smartindent = true -- Smart auto-indenting

-- Line wrapping
vim.opt.wrap = false -- Don't wrap lines by default
vim.opt.linebreak = true -- Wrap at word boundaries when wrap is enabled

-- Better backspace behavior
vim.opt.backspace = "indent,eol,start"

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                              Search                                         │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Search settings
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if uppercase letters are used
vim.opt.incsearch = true -- Incremental search
vim.opt.hlsearch = true -- Highlight search results

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                              Files/Buffers                                 │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- File handling
vim.opt.hidden = true -- Allow switching buffers without saving
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't create backup before overwriting
vim.opt.swapfile = false -- Don't use swap files

-- Persistent undo
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                             Performance                                     │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Faster updates
vim.opt.updatetime = 50 -- Faster completion and CursorHold events
vim.opt.timeoutlen = 300 -- Faster which-key popup

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                             Application Specific                           │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Neovide specific settings
if vim.g.neovide then
    vim.g.neovide_transparency = 0.99
    vim.g.neovide_cursor_animation_length = 0.05
    vim.g.neovide_cursor_trail_size = 0.3
end

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                             File Type Detection                            │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Custom file type associations
vim.filetype.add({
    extension = {
        templ = "templ", -- Go templates
        conf = "conf",
        env = "sh",
    },
    filename = {
        [".env"] = "sh",
        ["tsconfig.json"] = "jsonc",
    },
    pattern = {
        ["%.env%..*"] = "sh", -- .env.local, .env.production, etc.
    },
})

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                              Global Variables                               │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Check if we have a nerd font for better icons
vim.g.have_nerd_font = true

-- Disable some built-in plugins we don't need
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
