-- ===================================================================
-- TROUBLE CONFIGURATION
-- Diagnostics and problem management interface
-- ===================================================================

return {
    "folke/trouble.nvim",
    
    dependencies = { "nvim-tree/nvim-web-devicons" },
    
    opts = {
        -- ===================================================================
        -- TROUBLE CONFIGURATION OPTIONS
        -- ===================================================================
        
        -- Window position and size
        position = "bottom",     -- Position: bottom, top, left, right
        height = 10,            -- Height when position is top/bottom
        width = 50,             -- Width when position is left/right
        
        -- Visual settings
        icons = true,           -- Use devicons for filenames
        mode = "workspace_diagnostics", -- Default mode
        
        -- Folding
        fold_open = "",         -- Icon for open folds
        fold_closed = "",       -- Icon for closed folds
        
        -- Group results
        group = true,           -- Group results by file
        padding = true,         -- Add extra padding
        
        -- Auto-close when no problems
        auto_close = false,     -- Don't auto-close when empty
        auto_open = false,      -- Don't auto-open on problems
        
        -- Signs configuration
        signs = {
            error = "",
            warning = "",
            hint = "",
            information = "",
            other = "",
        },
    },
    
    config = function()
        -- ===================================================================
        -- TROUBLE KEYMAPS
        -- Quick access to different problem views
        -- ===================================================================
        
        -- Main toggle for trouble (shows workspace diagnostics by default)
        vim.keymap.set("n", "<leader>pp", function() 
            require("trouble").toggle() 
        end, { desc = "Toggle trouble diagnostics panel" })
        
        -- Workspace-wide problems
        vim.keymap.set("n", "<leader>pw", function() 
            require("trouble").toggle("workspace_diagnostics") 
        end, { desc = "Show workspace diagnostics" })
        
        -- Current document problems only
        vim.keymap.set("n", "<leader>pd", function() 
            require("trouble").toggle("document_diagnostics") 
        end, { desc = "Show document diagnostics" })
        
        -- Quickfix list in trouble format
        vim.keymap.set("n", "<leader>pq", function() 
            require("trouble").toggle("quickfix") 
        end, { desc = "Show quickfix list" })
        
        -- Location list in trouble format
        vim.keymap.set("n", "<leader>pl", function() 
            require("trouble").toggle("loclist") 
        end, { desc = "Show location list" })
        
        -- LSP references for symbol under cursor
        vim.keymap.set("n", "<leader>gr", function() 
            require("trouble").toggle("lsp_references") 
        end, { desc = "Show LSP references" })
        
        -- ===================================================================
        -- NAVIGATION KEYMAPS (when trouble is open)
        -- ===================================================================
        
        -- Next/previous problem
        vim.keymap.set("n", "<leader>pn", function()
            require("trouble").next({skip_groups = true, jump = true})
        end, { desc = "Next problem" })
        
        vim.keymap.set("n", "<leader>pN", function()
            require("trouble").previous({skip_groups = true, jump = true})
        end, { desc = "Previous problem" })
        
        -- ===================================================================
        -- WHICH-KEY DOCUMENTATION
        -- Register keymaps for better discoverability
        -- ===================================================================
        local wk = require("which-key")
        wk.add({
            { "<leader>p", group = "problems/diagnostics" },
            { "<leader>pp", desc = "toggle trouble diagnostics panel" },
            { "<leader>pw", desc = "workspace diagnostics" },
            { "<leader>pd", desc = "document diagnostics" },
            { "<leader>pq", desc = "quickfix list" },
            { "<leader>pl", desc = "location list" },
            { "<leader>pn", desc = "next problem" },
            { "<leader>pN", desc = "previous problem" },
            { "<leader>g", group = "goto/LSP" },
            { "<leader>gr", desc = "LSP references" },
        })
    end
}
