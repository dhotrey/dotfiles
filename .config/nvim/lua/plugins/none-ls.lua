-- ===================================================================
-- NONE-LS (NULL-LS) CONFIGURATION
-- Code formatting and diagnostics through external tools
-- ===================================================================

return {
    "nvimtools/none-ls.nvim",
    
    dependencies = {
        "nvim-lua/plenary.nvim",  -- Required dependency
    },
    
    config = function()
        local null_ls = require("null-ls")
        
        null_ls.setup({
            -- ===================================================================
            -- FORMATTING SOURCES
            -- External tools for code formatting
            -- ===================================================================
            sources = {
                -- Lua formatting
                null_ls.builtins.formatting.stylua.with({
                    extra_args = { "--config-path", vim.fn.expand("~/.config/nvim/stylua.toml") },
                }),
                
                -- Go formatting
                null_ls.builtins.formatting.gofumpt.with({
                    extra_args = { "-extra" }, -- More strict formatting
                }),
                
                -- Python formatting
                null_ls.builtins.formatting.black.with({
                    extra_args = { "--line-length", "88" },
                }),
                
                -- Python import sorting
                null_ls.builtins.formatting.isort.with({
                    extra_args = { "--profile", "black" }, -- Compatible with black
                }),
                
                -- Additional formatters (currently disabled)
                -- Uncomment and configure as needed:
                
                -- Template formatting (Go templ)
                -- null_ls.builtins.formatting.templ,
                
                -- HTML formatting
                -- null_ls.builtins.formatting.prettier.with({
                --     filetypes = { "html", "css", "javascript", "typescript", "json" },
                -- }),
                
                -- Rust formatting (handled by rust-analyzer usually)
                -- null_ls.builtins.formatting.rustfmt,
                
                -- C/C++ formatting
                -- null_ls.builtins.formatting.clang_format,
            },
            
            -- ===================================================================
            -- GENERAL CONFIGURATION
            -- ===================================================================
            
            -- Format on save (can be overridden per buffer)
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ 
                                bufnr = bufnr,
                                timeout_ms = 3000,
                            })
                        end,
                    })
                end
            end,
            
            -- Debug mode (set to true for troubleshooting)
            debug = false,
        })
        
        -- ===================================================================
        -- FORMATTING KEYMAP
        -- Manual formatting trigger
        -- ===================================================================
        vim.keymap.set('n', '<leader>F', function()
            vim.lsp.buf.format({ 
                timeout_ms = 3000,
                async = false,
            })
        end, { desc = "Format current buffer" })
        
        -- Alternative: 'F' key for quick formatting (original keymap)
        vim.keymap.set('n', 'F', vim.lsp.buf.format, { desc = "Format buffer (quick)" })
    end
}
