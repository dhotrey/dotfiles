return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "lua_ls",
                    "gopls",
                    "pylsp",              -- ✅ Active Python LSP
                    -- "jedi_language_server", -- 💤 Alternative Python LSP (commented)
                    "rust_analyzer",     -- ✅ Added Rust support
                    "zls",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = vim.lsp.config -- ✅ new API
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Optional global on_attach function
            -- local on_attach = function(client, bufnr)
            --   -- custom buffer-local mappings, etc.
            -- end

            -- ✅ C / C++
            lspconfig("clangd", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- ✅ Lua
            lspconfig("lua_ls", {
                capabilities = capabilities,
            })

            -- ✅ Go
            lspconfig("gopls", {
                capabilities = capabilities,
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
            })

            -- ✅ Python (pylsp)
            lspconfig("pylsp", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- 💤 Alternative Python LSPs (commented)
            -- lspconfig("jedi_language_server", {
            --     capabilities = capabilities,
            -- })

            -- ✅ Rust
            lspconfig("rust_analyzer", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- ✅ Zig
            lspconfig("zls", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- Keymaps
            vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<CR>", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
            vim.keymap.set("n", "<leader>gi", vim.lsp.buf.definition, {})

            -- Which-key documentation
            local wk = require("which-key")
            local opts = { prefix = "<leader>" }
            local mappings = {
                c = {
                    name = "code",
                    a = "actions",
                },
                r = {
                    name = "rename",
                    n = "rename",
                },
                g = {
                    i = "implementation",
                },
                h = {
                    name = "hover for documentation",
                    h = "hover (show documentation)",
                },
            }
            wk.register(mappings, opts)
        end,
    },
}

