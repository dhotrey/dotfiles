-- ===================================================================
-- COMPLETION SYSTEM
-- Intelligent code completion with snippets and LSP integration
-- ===================================================================

return {
    -- ===================================================================
    -- CMP-NVIM-LSP
    -- LSP completion source for nvim-cmp
    -- ===================================================================
    {
        "hrsh7th/cmp-nvim-lsp"
    },

    -- ===================================================================
    -- LUASNIP & SNIPPET INTEGRATION
    -- Snippet engine and snippet collection
    -- ===================================================================
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",      -- LuaSnip completion source
            "rafamadriz/friendly-snippets"   -- Collection of useful snippets
        }
    },

    -- ===================================================================
    -- NVIM-CMP
    -- Main completion engine
    -- ===================================================================
    {
        "hrsh7th/nvim-cmp",
        
        config = function()
            local cmp = require('cmp')
            
            -- Load friendly-snippets for various languages
            require("luasnip.loaders.from_vscode").lazy_load()
            
            cmp.setup({
                -- ===================================================================
                -- SNIPPET CONFIGURATION
                -- ===================================================================
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },

                -- ===================================================================
                -- WINDOW APPEARANCE
                -- Bordered windows for better visibility
                -- ===================================================================
                window = {
                    completion = cmp.config.window.bordered({
                        border = 'rounded',
                        scrollbar = '║',
                    }),
                    documentation = cmp.config.window.bordered({
                        border = 'rounded',
                        scrollbar = '║',
                    }),
                },

                -- ===================================================================
                -- KEYMAPS FOR COMPLETION
                -- ===================================================================
                mapping = cmp.mapping.preset.insert({
                    -- Scroll documentation up/down
                    ['<C-j>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-k>'] = cmp.mapping.scroll_docs(4),
                    
                    -- Trigger completion manually
                    ['<C-Space>'] = cmp.mapping.complete(),
                    
                    -- Close completion menu
                    ['<C-e>'] = cmp.mapping.abort(),
                    
                    -- Accept selected completion item
                    ['<CR>'] = cmp.mapping.confirm({ 
                        select = true,  -- Accept first item if none selected
                        behavior = cmp.ConfirmBehavior.Replace 
                    }),
                    
                    -- Navigate through completion items
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif require("luasnip").expand_or_jumpable() then
                            require("luasnip").expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif require("luasnip").jumpable(-1) then
                            require("luasnip").jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),

                -- ===================================================================
                -- COMPLETION SOURCES
                -- Ordered by priority (higher priority first)
                -- ===================================================================
                sources = cmp.config.sources({
                    -- Primary sources (high priority)
                    { name = 'nvim_lsp' },    -- LSP completions
                    { name = 'luasnip' },     -- Snippet completions
                }, {
                    -- Secondary sources (lower priority)
                    { name = 'buffer' },      -- Buffer text completions
                    { name = 'path' },        -- File path completions
                }),

                -- ===================================================================
                -- FORMATTING
                -- Customize completion item appearance
                -- ===================================================================
                formatting = {
                    format = function(entry, vim_item)
                        -- Add source name to completion items
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        
                        return vim_item
                    end
                },

                -- ===================================================================
                -- EXPERIMENTAL FEATURES
                -- ===================================================================
                experimental = {
                    ghost_text = true,  -- Show preview of completion
                },
            })
        end
    }
}
