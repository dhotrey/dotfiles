-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                            Auto Commands                                   │
-- │                                                                             │
-- │ This file contains all autocommands (automatic commands that run on        │
-- │ specific events) for the Neovim configuration.                             │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                            Highlight on Yank                               │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Highlight yanked text briefly to give visual feedback
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                            File Type Settings                              │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Close certain filetypes with q
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                            Auto-resize Windows                             │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Resize splits if vim window is resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                            Language Specific                               │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Go file formatting (commented out as it may interfere with LSP formatting)
-- Uncomment and modify if you prefer gofumpt over LSP formatting
--[[
vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup("go_format"),
  pattern = "*.go",
  callback = function()
    local current_dir = vim.fn.getcwd()
    local buffer_dir = vim.fn.expand("%:p:h")
    vim.cmd("cd " .. buffer_dir)
    vim.cmd("!gofumpt -l -w .")
    vim.cmd("cd " .. current_dir)
  end,
})
--]]

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                            Buffer Management                               │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
