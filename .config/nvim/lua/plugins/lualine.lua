-- return {
--     'nvim-lualine/lualine.nvim',
--     config = function()
--         require('lualine').setup({
--             options = {
--                 theme = 'auto',
--                 sections = {
--                     lualine_a = {
--                         'filename',
--                         file_status = true,
--                         newfile_status = true,
--                         path = 3
--                     }
--                 }
--             }
--         })
--     end
-- }
return {
    'nvim-lualine/lualine.nvim',
    config = function()
        local lualine = require('lualine')

        -- Color table
        local colors = {
            bg       = '#202328',
            fg       = '#bbc2cf',
            yellow   = '#ECBE7B',
            cyan     = '#008080',
            darkblue = '#081633',
            green    = '#98be65',
            orange   = '#FF8800',
            violet   = '#a9a1e1',
            magenta  = '#c678dd',
            blue     = '#51afef',
            red      = '#ec5f67',
        }

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
        }
        local function get_harpoon_indicator(harpoon_entry)
            return harpoon_entry.value
        end

        local config = {
            options = {
                component_separators = '',
                section_separators = '',
                theme = 'auto',
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    "harpoon2",
                    -- {
                    --     "harpoon2",
                    --     icon = '♥',
                    --     indicators = { "1", "2", "3", "4" },
                    --     active_indicators = {
                    --         get_harpoon_indicator,
                    --         get_harpoon_indicator,
                    --         get_harpoon_indicator,
                    --         get_harpoon_indicator,
                    --         get_harpoon_indicator,
                    --         get_harpoon_indicator,
                    --     },
                    --     color_active = { fg = "#00ff00" },
                    --     _separator = " ",
                    --     no_harpoon = "Harpoon not loaded",
                    -- },
                    --
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        }

        local function ins_left(component)
            table.insert(config.sections.lualine_c, component)
        end

        local function ins_right(component)
            table.insert(config.sections.lualine_x, component)
        end


        ins_left {
            function() return '' end,
            color = function()
                local mode_color = {
                    n = colors.red,
                    i = colors.green,
                    v = colors.blue,
                    V = colors.blue,
                    c = colors.magenta,
                    R = colors.violet,
                }
                return { fg = mode_color[vim.fn.mode()] or colors.fg }
            end,
            padding = { right = 1 },
        }

        ins_left { 'filesize', cond = conditions.buffer_not_empty }

        ins_left {
            'filename',
            cond = conditions.buffer_not_empty,
            color = { fg = colors.magenta, gui = 'bold' },
        }

        ins_left { 'location' }
        ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

        ins_left {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
        }

        ins_left { function() return '%=' end }


        ins_right {
            'o:encoding',
            fmt = string.upper,
            cond = conditions.hide_in_width,
            color = { fg = colors.green, gui = 'bold' },
        }

        ins_right {
            'fileformat',
            fmt = string.upper,
            icons_enabled = false,
            color = { fg = colors.green, gui = 'bold' },
        }

        ins_right {
            'branch',
            icon = '',
            color = { fg = colors.violet, gui = 'bold' },
        }

        ins_right {
            'diff',
            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            cond = conditions.hide_in_width,
        }

        lualine.setup(config)
    end,
}
