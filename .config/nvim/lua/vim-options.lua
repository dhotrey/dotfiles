vim.cmd("set expandtab")
vim.g.mapleader = " "
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set nowrap")
vim.cmd("set incsearch")
vim.cmd("set ignorecase")
vim.g.neovide_transparency = 0.99

-- Run the 'gofumpt' command on saving a Go file
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--     pattern = "*.go",
--     callback = function()
--         local current_dir = vim.fn.getcwd()
--         local buffer_dir = vim.fn.expand("%:p:h")
--         vim.cmd("cd " .. buffer_dir)
--         vim.cmd("!gofumpt -l -w .")
--         vim.cmd("cd " .. current_dir)
--     end,
-- })
