return {
    'tanvirtin/vgit.nvim',
    config = function()
        local vgit = require('vgit')
        vgit.setup()
        vim.keymap.set('n', '<leader>vd', ':VGit buffer_diff_preview<CR>', {})
        -- documentation --
        local wk = require('which-key')
        local opts = { prefix = '<leader>' }
        local mappings = {
            v = {
                name = "VGit",
                d = "git diff"
            }
        }
        wk.register(mappings, opts)
    end
}
