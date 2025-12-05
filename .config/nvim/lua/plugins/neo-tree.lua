return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        filesystem = {
            filtered_items = {
                visible = true,
                show_hidden_count = true,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_by_name = {
                    ".git",
                },
            },
        },
        source_selector = {
            winbar = true,
            statusline = false,
        },
    },
    config = function(_, opts)
        vim.keymap.set("n", "<A-b>", ":Neotree filesystem toggle reveal right<CR>", { noremap = true, silent = true })
        require("neo-tree").setup(opts)
    end,
}

