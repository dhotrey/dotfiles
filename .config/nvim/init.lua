-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                             Neovim Configuration                            │
-- │                                                                             │
-- │ This is the main entry point for the Neovim configuration.                 │
-- │ It bootstraps lazy.nvim plugin manager and loads all configuration files.  │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Bootstrap lazy.nvim plugin manager if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration before plugins
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Setup lazy.nvim and load plugins
require("config.lazy")
