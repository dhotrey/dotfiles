return {
    "yanskun/gotests.nvim",
    ft = "go",
    config = function()
        require("gotests").setup()
        vim.keymap.set({ 'n', 'v' }, '<leader>to', ':GoTests<CR>', {})
        vim.keymap.set({ 'n', 'v' }, '<leader>ta', ':GoTestsAll<CR>', {})
        -- documentation --
        local wk = require('which-key')
        local opts = { prefix = '<leader>' }
        local mappings = {
            t = {
                name = "generate tests",
                a = "generate tests for all functions",
                o = "generate test for one function"
            },
        }
        wk.register(mappings, opts)
    end
}
