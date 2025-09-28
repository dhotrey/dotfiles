-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                               Auto Close                                   │
-- │                                                                             │
-- │ Automatically close brackets, quotes, and other pairs intelligently.      │
-- │ Provides smart pairing with context awareness and customizable rules.      │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
  "m4xshen/autoclose.nvim",
  event = "InsertEnter",
  opts = {
    -- Pairs to auto close
    keys = {
      ["("] = { escape = false, close = true, pair = "()" },
      ["["] = { escape = false, close = true, pair = "[]" },
      ["{"] = { escape = false, close = true, pair = "{}" },
      
      [">"] = { escape = true, close = false, pair = "<>" },
      [")"] = { escape = true, close = false, pair = "()" },
      ["]"] = { escape = true, close = false, pair = "[]" },
      ["}"] = { escape = true, close = false, pair = "{}" },
      
      ['"'] = { escape = true, close = true, pair = '""' },
      ["'"] = { escape = true, close = true, pair = "''" },
      ["`"] = { escape = true, close = true, pair = "``" },
    },
    options = {
      -- Disable when recording or executing a macro
      disabled_filetypes = { "text", "markdown" },
      -- Disable auto closing when cursor is next to a "\", for example: |\
      disable_when_touch = false,
      -- Pair the key only on deletion, not insertion
      touch_regex = "[%w(%[{]",
      -- Characters to pair, can be a table of list or string
      pair_spaces = false,
      -- Whether to auto close on line break, default false
      auto_indent = true,
      -- Disable when cursor is in a comment
      disable_command_mode = false,
    },
  },
}
