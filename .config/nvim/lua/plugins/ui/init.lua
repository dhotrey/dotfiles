-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                                UI Plugins                                  │
-- │                                                                             │
-- │ This module loads all UI-related plugins including themes, status lines,   │
-- │ dashboards, and other visual enhancements.                                 │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
  -- Load all UI plugins
  require("plugins.ui.github-theme"),
  require("plugins.ui.lualine"),
  require("plugins.ui.alpha-dashboard"),
}