-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                            Core Keymaps                                    │
-- │                                                                             │
-- │ This file contains core keymaps that don't belong to specific plugins.     │
-- │ Plugin-specific keymaps should be defined in their respective plugin files.│
-- ╰─────────────────────────────────────────────────────────────────────────────╯

local keymap = vim.keymap

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                           Window Navigation                                 │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Use Alt key for window operations (more ergonomic than Ctrl+w)
keymap.set("n", "<A-w>", "<C-w>", { desc = "Window command prefix", silent = true })
keymap.set("n", "<A-w><A-w>", "<C-w>w", { desc = "Switch to next window", silent = true })

-- Quick window navigation
keymap.set("n", "<A-h>", "<C-w>h", { desc = "Move to left window", silent = true })
keymap.set("n", "<A-j>", "<C-w>j", { desc = "Move to below window", silent = true })
keymap.set("n", "<A-k>", "<C-w>k", { desc = "Move to above window", silent = true })
keymap.set("n", "<A-l>", "<C-w>l", { desc = "Move to right window", silent = true })

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                            Insert Mode Shortcuts                           │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Delete word backward in insert mode (similar to terminal)
keymap.set("i", "<A-w>", "<C-w>", { desc = "Delete word backward", silent = true })

-- Alternative delete word mapping
keymap.set("i", "<A-e>", "<C-w>", { desc = "Delete word backward (alt)", silent = true })

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                            Navigation & History                             │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Jump back and forward in jump list
keymap.set("n", "<A-o>", "<C-o>", { desc = "Jump back in jump list", silent = true })
keymap.set("n", "<A-i>", "<C-i>", { desc = "Jump forward in jump list", silent = true })

-- Redo operation
keymap.set("n", "<A-r>", "<C-r>", { desc = "Redo", silent = true })

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                                Utilities                                    │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Clear search highlighting
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Better up/down navigation for wrapped lines
keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Stay in indent mode when indenting
keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                            Buffer Management                                │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Quick buffer navigation
keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                                Terminal                                     │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Terminal mode keymaps
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode to encourage hjkl usage
keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
