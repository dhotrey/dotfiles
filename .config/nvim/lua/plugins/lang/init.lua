-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                         Language-Specific Plugins                         │
-- │                                                                             │
-- │ This module loads plugins tailored for specific programming languages      │
-- │ including specialized tools, testing frameworks, and language features.    │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
  -- Load all language-specific plugins
  require("plugins.lang.gotest"),
  require("plugins.lang.markdown"),
}