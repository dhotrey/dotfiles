-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                              Completions                                   │
-- │                                                                             │
-- │ Auto-completion system with LSP integration, snippets, and various         │
-- │ completion sources. Provides intelligent code completion and expansion.     │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
  -- LSP completion source
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },
  
  -- Additional completion sources
  {
    "hrsh7th/cmp-buffer", -- Buffer completions
    lazy = true,
  },
  {
    "hrsh7th/cmp-path", -- Path completions
    lazy = true,
  },
  {
    "hrsh7th/cmp-cmdline", -- Command line completions
    lazy = true,
  },

  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip", -- Snippet completions
      "rafamadriz/friendly-snippets", -- Predefined snippets
    },
    config = function()
      local luasnip = require("luasnip")
      
      -- Load snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      
      -- Enable autotrigger snippets
      luasnip.config.setup({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })

      -- Keymaps for snippet navigation
      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { desc = "Expand or jump to next snippet placeholder", silent = true })

      vim.keymap.set({ "i", "s" }, "<C-h>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { desc = "Jump to previous snippet placeholder", silent = true })
    end,
  },

  -- Main completion plugin
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Custom completion item kind icons
      local kind_icons = {
        Text = "",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰇽",
        Variable = "󰂡",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰅲",
      }

      return {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            winhighlight = "Normal:CmpDoc",
          }),
        },
        formatting = {
          format = function(entry, vim_item)
            -- Set kind icons
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            
            -- Set source names
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              copilot = "[Copilot]",
            })[entry.source.name]
            
            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-j>"] = cmp.mapping.scroll_docs(4),
          ["<C-k>"] = cmp.mapping.scroll_docs(-4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false, -- Only confirm explicitly selected items
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "copilot", priority = 700 },
        }, {
          { name = "buffer", priority = 500, keyword_length = 3 },
          { name = "path", priority = 250 },
        }),
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      -- Setup cmdline completion
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}
