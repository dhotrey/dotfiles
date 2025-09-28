-- ===================================================================
-- TELESCOPE CONFIGURATION
-- Fuzzy finder and picker for files, buffers, and more
-- ===================================================================

return {
    -- ===================================================================
    -- MAIN TELESCOPE PLUGIN
    -- ===================================================================
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        
        config = function()
            local builtin = require("telescope.builtin")
            
            -- ===================================================================
            -- TELESCOPE KEYMAPS
            -- Fast file and content searching
            -- ===================================================================
            
            -- Alt+P: Find files in project (similar to Ctrl+P in many editors)
            vim.keymap.set("n", "<A-p>", builtin.find_files, { 
                desc = "Find files in project" 
            })
            
            -- Alt+F: Live grep (search for text content in files)
            vim.keymap.set("n", "<A-f>", builtin.live_grep, { 
                desc = "Search text in files (live grep)" 
            })
            
            -- Additional useful telescope functions that can be mapped:
            -- builtin.buffers          - Search open buffers
            -- builtin.help_tags        - Search help documentation
            -- builtin.oldfiles         - Recently opened files
            -- builtin.commands         - Available commands
            -- builtin.git_files        - Git tracked files only
            -- builtin.grep_string      - Search for word under cursor
            
            -- Optional additional keymaps (uncomment to enable):
            -- vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
            -- vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
            -- vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })
            -- vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Find commands" })
        end
    },

    -- ===================================================================
    -- TELESCOPE UI-SELECT
    -- Enhanced selection UI for LSP and other plugins
    -- ===================================================================
    {
        'nvim-telescope/telescope-ui-select.nvim',
        
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        -- Use telescope's dropdown theme for selections
                        require("telescope.themes").get_dropdown({
                            -- Additional theming options:
                            -- winblend = 10,           -- Transparency
                            -- layout_config = {
                            --     width = 0.8,          -- Width percentage
                            --     height = 0.8,         -- Height percentage
                            -- },
                        })
                    }
                },
                
                -- ===================================================================
                -- GENERAL TELESCOPE CONFIGURATION
                -- ===================================================================
                defaults = {
                    -- Search configuration
                    file_ignore_patterns = {
                        "node_modules/",
                        ".git/",
                        "dist/",
                        "build/",
                        "*.lock",
                    },
                    
                    -- Layout configuration
                    layout_config = {
                        horizontal = {
                            preview_width = 0.55,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    
                    -- Appearance
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    
                    -- Performance
                    cache_picker = {
                        num_pickers = 5,
                    },
                }
            })
            
            -- Load the ui-select extension
            require("telescope").load_extension("ui-select")
        end
    }
}
