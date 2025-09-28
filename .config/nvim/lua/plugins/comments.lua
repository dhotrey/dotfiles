-- ===================================================================
-- COMMENT PLUGIN
-- Smart commenting functionality for multiple filetypes
-- ===================================================================

return {
    'numToStr/Comment.nvim',
    
    -- Plugin description and purpose
    -- This plugin provides intelligent commenting functionality that:
    -- - Automatically detects filetype and uses appropriate comment syntax
    -- - Supports line and block commenting
    -- - Works with visual selections
    -- - Provides consistent keymaps across all filetypes
    
    opts = {
        -- Additional configuration can be added here
        -- Examples:
        -- padding = true,        -- Add space after comment delimiters
        -- sticky = true,         -- Maintain cursor position when commenting
        -- ignore = nil,          -- Lines to ignore while commenting
        -- toggler = {            -- Keymaps for toggling comments
        --     line = 'gcc',      -- Line-comment keymap
        --     block = 'gbc',     -- Block-comment keymap
        -- },
        -- opleader = {           -- Keymaps for operator-pending mode
        --     line = 'gc',       -- Line-comment keymap
        --     block = 'gb',      -- Block-comment keymap
        -- },
    },
    
    -- Load immediately for better UX
    lazy = false,
    
    -- Default keymaps provided by Comment.nvim:
    -- Normal mode:
    --   gcc - Toggle line comment
    --   gbc - Toggle block comment
    --   gc[count]{motion} - Toggle comment using motion
    --   gb[count]{motion} - Toggle block comment using motion
    -- Visual mode:
    --   gc - Toggle line comment
    --   gb - Toggle block comment
}
