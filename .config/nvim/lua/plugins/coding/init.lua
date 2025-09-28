-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                             Coding Plugins                                 │
-- │                                                                             │
-- │ This module loads all coding-related plugins including completion,         │
-- │ snippets, auto-pairing, commenting, and AI assistance.                     │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
  -- Load all coding plugins
  require("plugins.coding.completions"),
  require("plugins.coding.comments"),
  require("plugins.coding.autoclose"),
  require("plugins.coding.copilot"),
}