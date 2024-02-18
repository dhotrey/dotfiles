return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim"
    },
    opts = {
        filesystem = {
            filtered_items = {
                visible = true,
                show_hidden_count = true,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_by_name = {
                    '.git',
                },
            },
        },
    },
    config = function()
        vim.keymap.set("n", "<C-b>", ":Neotree filesystem toggle reveal right<CR>", {

        })
        local ntree = require("neo-tree")
        ntree.setup({
            source_selector = {
                winbar = true,
                statusline = false
            }
        })
    end
}
