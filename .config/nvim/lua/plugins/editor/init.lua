-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                              Editor Plugins                                │
-- │                                                                             │
-- │ This module loads all editor-related plugins including file explorers,     │
-- │ fuzzy finders, syntax highlighting, and navigation enhancements.           │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
  -- Load all editor plugins
  require("plugins.editor.neo-tree"),
  require("plugins.editor.telescope"),
  require("plugins.editor.treesitter"),
  require("plugins.editor.harpoon"),
  require("plugins.editor.which-key"),
}