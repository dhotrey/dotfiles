return {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    priority = 1000,
    config = function()
        local mode_file = vim.fn.expand("~/.config/theme-mode")

        local function theme_for_current_mode()
            if vim.fn.filereadable(mode_file) == 1 then
                local mode = vim.fn.readfile(mode_file)[1]
                if mode == "light" then
                    return "github_light_colorblind"
                end
            end

            return "github_dark_colorblind"
        end

        local function apply_current_theme()
            local theme = theme_for_current_mode()
            if vim.g.colors_name ~= theme then
                vim.cmd.colorscheme(theme)
            end
        end

        apply_current_theme()

        -- Refresh an already-open Neovim when it regains focus after the
        -- light-mode/dark-mode shell command changes the shared mode file.
        vim.api.nvim_create_autocmd("FocusGained", {
            callback = apply_current_theme,
            desc = "Sync Neovim theme with the desktop mode",
        })
    end
}
