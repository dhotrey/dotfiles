-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                               Comments                                     │
-- │                                                                             │
-- │ Smart and powerful comment plugin with support for multiple languages,    │
-- │ context-aware commenting, and treesitter integration.                      │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring", -- Context-aware commenting
  },
  keys = {
    { "gcc", desc = "Comment toggle current line" },
    { "gc", desc = "Comment toggle linewise", mode = { "n", "o" } },
    { "gc", desc = "Comment toggle linewise (visual)", mode = "x" },
    { "gbc", desc = "Comment toggle current block" },
    { "gb", desc = "Comment toggle blockwise", mode = { "n", "o" } },
    { "gb", desc = "Comment toggle blockwise (visual)", mode = "x" },
  },
  opts = function()
    return {
      -- Add a space between comment and the line
      padding = true,
      -- Whether the cursor should stay at its position
      sticky = true,
      -- Lines to be ignored while (un)comment
      ignore = "^$",
      -- LHS of toggle mappings in NORMAL mode
      toggler = {
        line = "gcc", -- Line-comment toggle keymap
        block = "gbc", -- Block-comment toggle keymap
      },
      -- LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        line = "gc", -- Line-comment keymap
        block = "gb", -- Block-comment keymap
      },
      -- LHS of extra mappings
      extra = {
        above = "gcO", -- Add comment on the line above
        below = "gco", -- Add comment on the line below
        eol = "gcA", -- Add comment at the end of line
      },
      -- Enable/disable keybindings
      mappings = {
        basic = true, -- Operator-pending mapping (gcc, gbc, gc[count]{motion}, gb[count]{motion})
        extra = true, -- Extra mapping (gco, gcO, gcA)
      },
      -- Function to call before (un)comment
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      -- Function to call after (un)comment
      post_hook = nil,
    }
  end,
}
