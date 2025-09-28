return {
    'nvim-lualine/lualine.nvim',
    config = function()
        require('lualine').setup({ -- TODO : does not work as intended, fix later
            options = {
                theme = 'auto',
                sections = {
                    lualine_a = {
                        'filename',
                        file_status = true,
                        newfile_status = true,
                        path = 3
                    }
                }
            }
        })
    end
}
