-- ===================================================================
-- TREESITTER CONFIGURATION
-- Advanced syntax highlighting and code understanding
-- ===================================================================

return {
    "nvim-treesitter/nvim-treesitter",
    
    -- Build/update treesitter parsers on install/update
    build = ":TSUpdate",
    
    config = function()
        local config = require("nvim-treesitter.configs")
        
        config.setup({
            -- ===================================================================
            -- PARSER INSTALLATION
            -- Languages to automatically install parsers for
            -- ===================================================================
            ensure_installed = {
                -- System & Config Languages
                "lua",           -- Neovim configuration
                "yaml",          -- YAML configuration files
                "json",          -- JSON data files
                "ini",           -- INI configuration files
                "dockerfile",    -- Docker containerization
                "make",          -- Makefile build system
                "vimdoc",        -- Vim documentation
                
                -- Programming Languages
                "python",        -- Python development
                "go",            -- Go development
                "gomod",         -- Go modules
                "gowork",        -- Go workspaces
                "gosum",         -- Go checksums
                "c",             -- C programming
                "cpp",           -- C++ programming
                "java",          -- Java development
                "javascript",    -- JavaScript development
                "rust",          -- Rust programming (if available)
                
                -- Web Technologies
                "html",          -- HTML markup
                "css",           -- CSS styling
                "templ",         -- Go template engine
                
                -- Database & Query Languages
                "sql",           -- SQL databases
                "proto",         -- Protocol Buffers
                
                -- Documentation
                "markdown",      -- Markdown documentation
                "markdown_inline", -- Inline markdown
            },
            
            -- ===================================================================
            -- AUTOMATIC FEATURES
            -- ===================================================================
            
            -- Automatically install parsers for opened files
            auto_install = true,
            
            -- ===================================================================
            -- SYNTAX HIGHLIGHTING
            -- Superior syntax highlighting compared to traditional regex-based highlighting
            -- ===================================================================
            highlight = { 
                enable = true,
                -- Optional: disable for specific filetypes
                -- disable = { "c", "rust" },
                
                -- Optional: use additional vim regex highlighting
                -- additional_vim_regex_highlighting = false,
            },
            
            -- ===================================================================
            -- SMART INDENTATION
            -- Improved indentation based on treesitter understanding
            -- ===================================================================
            indent = { 
                enable = true,
                -- Optional: disable for specific filetypes that have issues
                -- disable = { "python", "yaml" },
            },
            
            -- ===================================================================
            -- ADDITIONAL FEATURES (can be enabled)
            -- ===================================================================
            
            -- Incremental selection based on treesitter nodes
            -- incremental_selection = {
            --     enable = true,
            --     keymaps = {
            --         init_selection = "gnn",
            --         node_incremental = "grn",
            --         scope_incremental = "grc",
            --         node_decremental = "grm",
            --     },
            -- },
            
            -- Text objects for better navigation and selection
            -- textobjects = {
            --     select = {
            --         enable = true,
            --         lookahead = true,
            --         keymaps = {
            --             ["af"] = "@function.outer",
            --             ["if"] = "@function.inner",
            --             ["ac"] = "@class.outer",
            --             ["ic"] = "@class.inner",
            --         },
            --     },
            -- },
        })
        
        -- ===================================================================
        -- FOLDING CONFIGURATION
        -- Enable treesitter-based folding for better code folding
        -- ===================================================================
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldenable = false  -- Don't fold by default
    end
}
