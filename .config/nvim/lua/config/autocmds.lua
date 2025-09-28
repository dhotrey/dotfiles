-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- ===================================================================
-- GO LANGUAGE FORMATTING
-- ===================================================================

-- Auto-format Go files with gofumpt on save
-- Note: This is currently commented out as it may interfere with LSP formatting
-- Uncomment and modify as needed for your workflow
--[[
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = "*.go",
    desc = "Format Go files with gofumpt after saving",
    callback = function()
        local current_dir = vim.fn.getcwd()
        local buffer_dir = vim.fn.expand("%:p:h")
        
        -- Change to buffer directory for formatting
        vim.cmd("cd " .. buffer_dir)
        vim.cmd("!gofumpt -l -w .")
        
        -- Return to original directory
        vim.cmd("cd " .. current_dir)
    end,
})
--]]

-- ===================================================================
-- ADDITIONAL AUTOCMDS
-- ===================================================================
-- Add more autocmds here as needed for your workflow
