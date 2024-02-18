return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup(
            {
                ensure_installed = {
                    "lua",
                    "python",
                    "go",
                    "gomod",
                    "gowork",
                    "gosum",
                    "sql",
                    "proto",
                    "html",
                    "css",
                    "c",
                    "cpp",
                    "vimdoc",
                    "yaml",
                    "ini",
                    "json",
                    "java",
                    "javascript",
                    "dockerfile",
                    "markdown_inline",
                    "make"
                },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true }
            }
        )
    end
}
