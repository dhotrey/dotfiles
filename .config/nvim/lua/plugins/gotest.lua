return {
    "yanskun/gotests.nvim",
    ft = "go",
    config = function()
        require("gotests").setup()
        vim.keymap.set({ 'n', 'v' }, '<leader>to', ':GoTests<CR>', {})
        vim.keymap.set({ 'n', 'v' }, '<leader>ta', ':GoTestsAll<CR>', {})
        -- documentation --
        local wk = require('which-key')
        wk.add({
            { "<leader>t", group = "generate tests" },
            { "<leader>ta", desc = "generate tests for all functions" },
            { "<leader>to", desc = "generate test for one function" },
        })
    end
}
