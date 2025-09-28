-- TODO this is not working 
return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
    },
    config = function ()
        local todo_tree = require("todo-comments")
        todo_tree.setup()
    end
}
