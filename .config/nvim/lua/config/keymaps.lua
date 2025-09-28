-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ===================================================================
-- WINDOW NAVIGATION (Alt-based keymaps)
-- ===================================================================

-- Window switching using Alt key instead of Ctrl-W
-- Alt+W starts window command mode (equivalent to Ctrl+W)
vim.keymap.set("n", "<A-w>", "<C-w>", { desc = "Window command mode", noremap = true, silent = true })

-- Alt+W+W switches between windows (equivalent to Ctrl+W+W)
vim.keymap.set("n", "<A-w><A-w>", "<C-w>w", { desc = "Switch windows", noremap = true, silent = true })

-- ===================================================================
-- INSERT MODE SHORTCUTS
-- ===================================================================

-- Alt+W in insert mode deletes a word backward (equivalent to Ctrl+W)
vim.keymap.set("i", "<A-w>", "<C-w>", { desc = "Delete word backward", noremap = true, silent = true })

-- Alt+E in insert mode (alternative word deletion - might be redundant)
vim.keymap.set("i", "<A-e>", "<C-w>", { desc = "Delete word backward (alt)", noremap = true, silent = true })

-- ===================================================================
-- NAVIGATION AND DISPLAY
-- ===================================================================

-- Alt+L clears and redraws the screen (equivalent to Ctrl+L)
vim.keymap.set("n", "<A-l>", "<C-l>", { desc = "Clear and redraw screen", noremap = true, silent = true })

-- Alt+O jumps to previous cursor position (equivalent to Ctrl+O)
vim.keymap.set("n", "<A-o>", "<C-o>", { desc = "Jump to previous location", noremap = true, silent = true })

-- Alt+R redo changes (equivalent to Ctrl+R)
vim.keymap.set("n", "<A-r>", "<C-r>", { desc = "Redo changes", noremap = true, silent = true })

-- ===================================================================
-- NOTES ON KEYMAPS
-- ===================================================================
-- These keymaps provide Alt-based alternatives to common Ctrl-based commands
-- This is useful for systems where Ctrl combinations might conflict with
-- terminal or system shortcuts, or for users who prefer Alt-based navigation
