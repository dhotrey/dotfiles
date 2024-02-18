return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "ruff_lsp",
                    "jedi_language_server" }

            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
            lspconfig.gopls.setup({
                capabilities = capabilities
            })
            lspconfig.ruff_lsp.setup({
                on_attach = on_attach
            })
            lspconfig.jedi_language_server.setup({
                --on_attach = on_attach
                capabilities = capabilities
            })
            vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, {})
            vim.keymap.set('n', '<Enter>', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
            vim.keymap.set('n', '<leader>gi', vim.lsp.buf.definition, {})
            -- documentation --
            local wk = require('which-key')
            local opts = { prefix = '<leader>' }
            local mappings = {
                c = {
                    name = "code",
                    a = "actions"
                },
                r = {
                    name = "rename",
                    n = "rename"
                },
                g = {
                    i = "implementation"
                },
                h = {
                    name = "hover for documentation",
                    h = "hover (show documentation)"
                }
            }
            wk.register(mappings, opts)
        end
    }
}
