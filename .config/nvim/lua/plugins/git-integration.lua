return {
    'tanvirtin/vgit.nvim',
    config = function()
        local vgit = require('vgit')
        vgit.setup()
        vim.keymap.set('n', '<leader>vd', ':VGit buffer_diff_preview<CR>', {})
        -- documentation --
        local wk = require('which-key')
        wk.add({
            { "<leader>v", group = "VGit" },
            { "<leader>vd", desc = "git diff" },
        })
    end
}
