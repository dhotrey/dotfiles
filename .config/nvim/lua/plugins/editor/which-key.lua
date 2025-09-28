-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                              Which-Key                                     │
-- │                                                                             │
-- │ Displays a popup with possible key bindings of the command you started     │
-- │ typing. Essential for discovering and remembering keybindings.              │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300 -- Faster which-key popup
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  opts = {
    -- Configure the popup window
    preset = "modern", -- Use modern preset for better appearance
    delay = 200, -- Delay before showing which-key popup
    expand = 1, -- expand groups when <= n mappings
    notify = true, -- show a notification when no mappings are found
    
    -- Configure icons
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
      ellipsis = "…",
      -- set to false to disable all mapping icons,
      -- both those explicitly added in a mapping
      -- and those from rules
      mappings = vim.g.have_nerd_font,
      -- use the highlights from mini.icons
      -- When `false`, it will use `WhichKeyIcon` instead
      colors = true,
      -- used by key format
      keys = {
        Up = " ",
        Down = " ",
        Left = " ",
        Right = " ",
        C = "󰘴 ",
        M = "󰘵 ",
        D = "󰘳 ",
        S = "󰘶 ",
        CR = "󰌑 ",
        Esc = "󱊷 ",
        ScrollWheelDown = "󱕐 ",
        ScrollWheelUp = "󱕑 ",
        NL = "󰌑 ",
        BS = "󰁮",
        Space = "󱁐 ",
        Tab = "󰌒 ",
        F1 = "󱊫 ",
        F2 = "󱊬 ",
        F3 = "󱊭 ",
        F4 = "󱊮 ",
        F5 = "󱊯 ",
        F6 = "󱊰 ",
        F7 = "󱊱 ",
        F8 = "󱊲 ",
        F9 = "󱊳 ",
        F10 = "󱊴 ",
        F11 = "󱊵 ",
        F12 = "󱊶 ",
      },
    },
    
    -- Disable which-key for certain buffer types and file types
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
    
    -- Configure layout
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    
    -- Configure sorting
    sort = { "local", "order", "group", "alphanum", "mod" },
    
    -- Configure filtering
    filter = function(mapping)
      -- example to exclude mappings without a description
      return mapping.desc and mapping.desc ~= ""
    end,
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    
    -- Define key group labels
    wk.add({
      -- Main groups
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug/Diagnostics" },
      { "<leader>f", group = "Find/File" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>l", group = "LSP" },
      { "<leader>r", group = "Rename/Replace" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Test/Toggle" },
      { "<leader>u", group = "UI" },
      { "<leader>w", group = "Workspace" },
      { "<leader>x", group = "Trouble/Diagnostics" },
      
      -- Git groups
      { "<leader>gc", group = "Commits" },
      { "<leader>gh", group = "Hunks" },
      
      -- Buffer groups
      { "<leader>b", group = "Buffer" },
      
      -- Window groups
      { "<leader>w", group = "Window" },
      
      -- Terminal groups
      { "<leader>T", group = "Terminal" },
    })
  end,
}
