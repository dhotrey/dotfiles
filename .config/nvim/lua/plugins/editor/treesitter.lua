-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                              Treesitter                                    │
-- │                                                                             │
-- │ Advanced syntax highlighting, indentation, and code understanding using    │
-- │ tree-sitter parsers. Provides superior highlighting and text objects.      │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- Use latest git commit
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects", -- Enhanced text objects
    "JoosepAlviste/nvim-ts-context-commentstring", -- Context-aware commenting
  },
  keys = {
    { "<c-space>", desc = "Increment selection" },
    { "<bs>", desc = "Decrement selection", mode = "x" },
  },
  opts = {
    -- Languages to ensure are installed
    ensure_installed = {
      -- Configuration and markup
      "lua",
      "vim",
      "vimdoc",
      "markdown",
      "markdown_inline",
      "html",
      "css",
      "json",
      "jsonc",
      "yaml",
      "toml",
      "xml",
      
      -- Programming languages
      "python",
      "go",
      "gomod",
      "gowork",
      "gosum",
      "c",
      "cpp",
      "rust",
      "zig",
      "java",
      "javascript",
      "typescript",
      "tsx",
      
      -- Shell and system
      "bash",
      "dockerfile",
      "sql",
      "proto",
      "make",
      "cmake",
      "ini",
      
      -- Specialized
      "templ", -- Go templates
      "git_config",
      "git_rebase",
      "gitcommit",
      "gitignore",
      "diff",
      "regex",
    },
    
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    
    -- Automatically install missing parsers when entering buffer
    auto_install = true,
    
    -- List of parsers to ignore installing (for "all")
    ignore_install = {},
    
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      additional_vim_regex_highlighting = { "ruby" },
      -- Disable highlighting for large files
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    
    indent = {
      enable = true,
      -- Disable for languages that have poor treesitter indentation
      disable = { "python", "css" },
    },
    
    -- Incremental selection
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    
    -- Text objects
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ii"] = "@conditional.inner",
          ["ai"] = "@conditional.outer",
          ["il"] = "@loop.inner",
          ["al"] = "@loop.outer",
          ["at"] = "@comment.outer",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
          ["]i"] = "@conditional.outer",
          ["]l"] = "@loop.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
          ["]I"] = "@conditional.outer",
          ["]L"] = "@loop.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
          ["[i"] = "@conditional.outer",
          ["[l"] = "@loop.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
          ["[I"] = "@conditional.outer",
          ["[L"] = "@loop.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    
    -- Setup context commentstring
    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })
  end,
}
