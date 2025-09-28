return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.gofumpt,
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort,
            -- null_ls.builtins.formatting.templ,
            -- null_ls.builtins.formatting.htmx,
            -- null_ls.builtins.formatting.html,
            -- null_ls.builtins.formatting.gleam
        })
        vim.keymap.set('n', 'F', vim.lsp.buf.format, {})
    end
}
