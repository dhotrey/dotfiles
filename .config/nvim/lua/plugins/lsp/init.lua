-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │                               LSP Plugins                                  │
-- │                                                                             │
-- │ This module loads all Language Server Protocol related plugins including   │
-- │ server management, diagnostics, formatting, and error handling.            │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
  -- Load all LSP plugins
  require("plugins.lsp.lsp-config"),
  require("plugins.lsp.none-ls"),
  require("plugins.lsp.trouble"),
}