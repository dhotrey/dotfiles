-- ===================================================================
-- HARPOON CONFIGURATION
-- Quick file navigation and project bookmarking
-- ===================================================================

return {
    "ThePrimeagen/harpoon",
    
    -- Use harpoon2 branch for latest features
    branch = "harpoon2",
    
    dependencies = { "nvim-lua/plenary.nvim" },
    
    config = function()
        local harpoon = require("harpoon")
        
        -- ===================================================================
        -- HARPOON SETUP
        -- ===================================================================
        harpoon:setup({
            -- Configuration options
            settings = {
                save_on_toggle = false,      -- Don't save on toggle
                sync_on_ui_close = true,     -- Sync when UI closes
                key = function()
                    return vim.loop.cwd()    -- Use current working directory as key
                end,
            },
            
            -- Optional: customize the display
            -- menu = {
            --     width = vim.api.nvim_win_get_width(0) - 4,
            -- }
        })
        
        -- ===================================================================
        -- HARPOON KEYMAPS
        -- ===================================================================
        
        -- Add current buffer to harpoon list
        vim.keymap.set("n", "<leader>a", function() 
            harpoon:list():add() 
        end, { desc = "Add current buffer to harpoon" })
        
        -- Toggle harpoon quick menu (two different keymaps for convenience)
        vim.keymap.set("n", "<leader><tab>", function() 
            harpoon.ui:toggle_quick_menu(harpoon:list()) 
        end, { desc = "Toggle harpoon menu" })
        
        vim.keymap.set("n", "<A-e>", function() 
            harpoon.ui:toggle_quick_menu(harpoon:list()) 
        end, { desc = "Toggle harpoon menu (Alt-E)" })
        
        -- ===================================================================
        -- DIRECT FILE ACCESS
        -- Quick access to frequently used files (1-4)
        -- ===================================================================
        vim.keymap.set("n", "<A-1>", function() 
            harpoon:list():select(1) 
        end, { desc = "Go to harpoon file 1" })
        
        vim.keymap.set("n", "<A-2>", function() 
            harpoon:list():select(2) 
        end, { desc = "Go to harpoon file 2" })
        
        vim.keymap.set("n", "<A-3>", function() 
            harpoon:list():select(3) 
        end, { desc = "Go to harpoon file 3" })
        
        vim.keymap.set("n", "<A-4>", function() 
            harpoon:list():select(4) 
        end, { desc = "Go to harpoon file 4" })
        
        -- ===================================================================
        -- NAVIGATION THROUGH HARPOON LIST
        -- Cycle through harpooned files
        -- ===================================================================
        vim.keymap.set("n", "<A-P>", function() 
            harpoon:list():prev() 
        end, { desc = "Go to previous harpoon file" })
        
        vim.keymap.set("n", "<A-N>", function() 
            harpoon:list():next() 
        end, { desc = "Go to next harpoon file" })
        
        -- ===================================================================
        -- WHICH-KEY DOCUMENTATION
        -- ===================================================================
        local wk = require("which-key")
        wk.add({
            { "<leader>a", desc = "add current buffer to harpoon" },
            { "<leader><tab>", desc = "toggle harpoon menu" },
        })
    end
}
