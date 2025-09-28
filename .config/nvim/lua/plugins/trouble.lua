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
        wk.add({
            { "<leader>p", group = "problem" },
            { "<leader>pp", desc = "im not sure what pp does" },
            { "<leader>pw", desc = "toggle problems inside the workspace" },
            { "<leader>pd", desc = "toggle problems inside the document" },
            { "<leader>pq", desc = "toggle quickfixes for problems" },
            { "<leader>pl", desc = "toggle loclist" },
            { "<leader>g", group = "goto " },
            { "<leader>gr", desc = "toggle lsp references" },
            { "<leader>a", group = "add buffer to harpoon" },
        })
    end
}
