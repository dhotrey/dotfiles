-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                              Tools Plugins                                 │
-- │                                                                             │
-- │ This module loads development tools including git integration, debugging,   │
-- │ task management, and productivity enhancements.                             │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
  -- Load all tool plugins
  require("plugins.tools.git-integration"),
  require("plugins.tools.debugging"),
  require("plugins.tools.todo-tree"),
  require("plugins.tools.wakatime"),
  require("plugins.tools.vim-be-good"),
}