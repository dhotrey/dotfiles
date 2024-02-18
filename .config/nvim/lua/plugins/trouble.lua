return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
    },
    config = function()
        vim.keymap.set("n", "<leader>pp", function() require("trouble").toggle() end)
        vim.keymap.set("n", "<leader>pw", function() require("trouble").toggle("workspace_diagnostics") end)
        vim.keymap.set("n", "<leader>pd", function() require("trouble").toggle("document_diagnostics") end)
        vim.keymap.set("n", "<leader>pq", function() require("trouble").toggle("quickfix") end)
        vim.keymap.set("n", "<leader>pl", function() require("trouble").toggle("loclist") end)
        vim.keymap.set("n", "<leader>gr", function() require("trouble").toggle("lsp_references") end)
        -- documentation --
        local wk = require("which-key")
        local opts = {
            prefix = "<leader>"
        }
        local mappings = {
            p = {
                name = "problem",
                p = "im not sure what pp does",
                w = "toggle problems inside the workspace",
                d = "toggle problems inside the document",
                q = "toggle quickfixes for problems",
                l = "toggle loclist"
            },
            g = {
                name = "goto ",
                r = "toggle lsp references"
            }
        }
        wk.register(mappings, opts)
    end
}
