-- ===================================================================
-- LSP CONFIGURATION
-- Language Server Protocol setup with Mason for automatic installation
-- ===================================================================

return {
    -- ===================================================================
    -- MASON: LSP/DAP/Linter installer and manager
    -- ===================================================================
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,
    },

    -- ===================================================================
    -- MASON-LSPCONFIG: Bridge between Mason and nvim-lspconfig
    -- ===================================================================
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                -- Automatically install these language servers
                ensure_installed = {
                    "clangd",        -- C/C++
                    "lua_ls",        -- Lua
                    "gopls",         -- Go
                    "pylsp",         -- Python (Stable choice)
                    "rust_analyzer", -- Rust
                    "zls",           -- Zig
                },
                -- Automatically install servers configured via lspconfig
                automatic_installation = true,
            })
        end,
    },

    -- ===================================================================
    -- LSPCONFIG: Neovim LSP client configurations
    -- ===================================================================
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Optional: Global on_attach function for common LSP keymaps
            -- You can customize this function to add buffer-local mappings
            local on_attach = function(client, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
                
                -- Additional on_attach logic can be added here
                -- For example: custom buffer-local keymaps, formatting setup, etc.
            end

            -- ===================================================================
            -- LANGUAGE SERVER CONFIGURATIONS
            -- ===================================================================

            -- C/C++ Language Server
            lspconfig.clangd.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
            })

            -- Lua Language Server
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim" }, -- Recognize 'vim' global in Neovim config
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false, -- Disable telemetry
                        },
                    },
                },
            })

            -- Go Language Server
            lspconfig.gopls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                settings = {
                    gopls = {
                        gofumpt = true,          -- Use gofumpt for formatting
                        codelenses = {
                            gc_details = false,
                            generate = true,
                            regenerate_cgo = true,
                            run_govulncheck = true,
                            test = true,
                            tidy = true,
                            upgrade_dependency = true,
                            vendor = true,
                        },
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                        analyses = {
                            fieldalignment = true,
                            nilness = true,
                            unusedparams = true,
                            unusedwrite = true,
                            useany = true,
                        },
                        usePlaceholders = true,
                        completeUnimported = true,
                        staticcheck = true,
                        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                        semanticTokens = true,
                    },
                },
            })

            -- Python Language Server (using pylsp - Python LSP Server)
            lspconfig.pylsp.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = {'W391'},
                                maxLineLength = 100,
                            },
                            pylsp_mypy = {
                                enabled = true,
                                live_mode = false,
                            },
                        },
                    },
                },
            })

            -- Rust Language Server
            lspconfig.rust_analyzer.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        assist = {
                            importGranularity = "module",
                            importPrefix = "by_self",
                        },
                        cargo = {
                            loadOutDirsFromCheck = true,
                        },
                        procMacro = {
                            enable = true,
                        },
                    },
                },
            })

            -- Zig Language Server
            lspconfig.zls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- ===================================================================
            -- LSP KEYMAPS
            -- Global keymaps for LSP functionality
            -- ===================================================================
            
            -- Show hover documentation
            vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, { desc = "Show hover documentation" })
            
            -- Go to definition
            vim.keymap.set("n", "<CR>", vim.lsp.buf.definition, { desc = "Go to definition" })
            vim.keymap.set("n", "<leader>gi", vim.lsp.buf.definition, { desc = "Go to definition (alt)" })
            
            -- Code actions
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
            
            -- Rename symbol
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

            -- ===================================================================
            -- WHICH-KEY DOCUMENTATION
            -- Register keymaps with which-key for better discoverability
            -- ===================================================================
            local wk = require("which-key")
            wk.add({
                { "<leader>c", group = "code" },
                { "<leader>ca", desc = "code actions" },
                { "<leader>r", group = "rename" },
                { "<leader>rn", desc = "rename symbol" },
                { "<leader>gi", desc = "go to implementation" },
                { "<leader>h", desc = "hover documentation" },
            })
        end,
    },
}

