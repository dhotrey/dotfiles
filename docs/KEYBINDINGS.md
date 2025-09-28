# Keybindings Reference

This document provides a comprehensive reference for all keybindings in this Neovim configuration.

## 🎯 Leader Keys

- **Leader**: `<Space>` (Space)
- **Local Leader**: `\` (Backslash)

## 🔧 Core Keybindings

### Window Management
| Key | Mode | Description |
|-----|------|-------------|
| `<A-w>` | Normal | Window command prefix (replaces `<C-w>`) |
| `<A-w><A-w>` | Normal | Switch to next window |
| `<A-h>` | Normal | Move to left window |
| `<A-j>` | Normal | Move to below window |
| `<A-k>` | Normal | Move to above window |
| `<A-l>` | Normal | Move to right window |

### Navigation & History
| Key | Mode | Description |
|-----|------|-------------|
| `<A-o>` | Normal | Jump back in jump list |
| `<A-i>` | Normal | Jump forward in jump list |
| `<A-r>` | Normal | Redo operation |
| `j` | Normal/Visual | Move down (gj for wrapped lines) |
| `k` | Normal/Visual | Move up (gk for wrapped lines) |

### Buffer Management
| Key | Mode | Description |
|-----|------|-------------|
| `[b` | Normal | Previous buffer |
| `]b` | Normal | Next buffer |

### Editing
| Key | Mode | Description |
|-----|------|-------------|
| `<A-w>` | Insert | Delete word backward |
| `<A-e>` | Insert | Delete word backward (alternative) |
| `<` | Visual | Indent left and reselect |
| `>` | Visual | Indent right and reselect |
| `<Esc>` | Normal | Clear search highlights |

### Terminal
| Key | Mode | Description |
|-----|------|-------------|
| `<Esc><Esc>` | Terminal | Exit terminal mode |

## 🔍 Telescope (Fuzzy Finder)

### File Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `<A-p>` | Normal | Find files |
| `<A-f>` | Normal | Live grep (search in files) |
| `<leader>fb` | Normal | Find buffers |
| `<leader>fr` | Normal | Recent files |
| `<leader>/` | Normal | Search in current buffer |

### Git Integration
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gc` | Normal | Git commits |
| `<leader>gs` | Normal | Git status |

### LSP Integration
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>lr` | Normal | LSP references |
| `<leader>ls` | Normal | Document symbols |
| `<leader>lS` | Normal | Workspace symbols |

### Search & Help
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sh` | Normal | Search help tags |
| `<leader>sk` | Normal | Search keymaps |
| `<leader>sc` | Normal | Search commands |
| `<leader>:` | Normal | Command history |
| `<leader>sw` | Normal/Visual | Search word under cursor |

### Telescope Navigation (Inside Telescope)
| Key | Mode | Description |
|-----|------|-------------|
| `<C-n>` | Insert | Next in history |
| `<C-p>` | Insert | Previous in history |
| `<C-j>` | Insert | Move selection down |
| `<C-k>` | Insert | Move selection up |
| `<C-u>` | Insert/Normal | Preview scroll up |
| `<C-d>` | Insert/Normal | Preview scroll down |
| `<C-x>` | Insert/Normal | Open in horizontal split |
| `<C-v>` | Insert/Normal | Open in vertical split |
| `<C-t>` | Insert/Normal | Open in new tab |
| `<Tab>` | Insert/Normal | Toggle selection |
| `<C-q>` | Insert/Normal | Send to quickfix |

## 🔧 LSP (Language Server Protocol)

### Core LSP Functions
| Key | Mode | Description |
|-----|------|-------------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gr` | Normal | Go to references |
| `gI` | Normal | Go to implementation |
| `K` | Normal | Hover documentation |
| `<leader>D` | Normal | Type definition |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>ca` | Normal/Visual | Code action |

### Symbol Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ds` | Normal | Document symbols |
| `<leader>ws` | Normal | Workspace symbols |

### Language-Specific
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>cR` | Normal | Switch C/C++ source/header |

## 🚨 Trouble (Diagnostics)

### Toggle Lists
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>xx` | Normal | Toggle diagnostics |
| `<leader>xX` | Normal | Buffer diagnostics |
| `<leader>cs` | Normal | Symbols (Trouble) |
| `<leader>cl` | Normal | LSP definitions/references |
| `<leader>xL` | Normal | Location list |
| `<leader>xQ` | Normal | Quickfix list |

### Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `[q` | Normal | Previous diagnostic/quickfix |
| `]q` | Normal | Next diagnostic/quickfix |

## 💬 Comments

| Key | Mode | Description |
|-----|------|-------------|
| `gcc` | Normal | Toggle line comment |
| `gbc` | Normal | Toggle block comment |
| `gc` | Normal/Visual | Comment toggle linewise |
| `gb` | Normal/Visual | Comment toggle blockwise |
| `gcO` | Normal | Add comment above |
| `gco` | Normal | Add comment below |
| `gcA` | Normal | Add comment at end of line |

## 🎯 Completion (nvim-cmp)

### In Completion Menu
| Key | Mode | Description |
|-----|------|-------------|
| `<C-n>` | Insert | Next completion item |
| `<C-p>` | Insert | Previous completion item |
| `<C-j>` | Insert | Scroll docs down |
| `<C-k>` | Insert | Scroll docs up |
| `<C-Space>` | Insert | Trigger completion |
| `<C-e>` | Insert | Abort completion |
| `<CR>` | Insert | Confirm selection |
| `<Tab>` | Insert | Next item or expand snippet |
| `<S-Tab>` | Insert | Previous item or jump back |

### Snippets (LuaSnip)
| Key | Mode | Description |
|-----|------|-------------|
| `<C-l>` | Insert/Select | Expand or jump to next placeholder |
| `<C-h>` | Insert/Select | Jump to previous placeholder |

## 🗂️ Neo-tree (File Explorer)

### Basic Navigation
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>e` | Normal | Toggle file explorer |
| `<leader>E` | Normal | Focus file explorer |

### Inside Neo-tree
| Key | Description |
|-----|-------------|
| `<CR>` | Open file/expand directory |
| `<Space>` | Toggle node |
| `a` | Add file/directory |
| `d` | Delete |
| `r` | Rename |
| `c` | Copy |
| `x` | Cut |
| `p` | Paste |
| `y` | Copy filename |
| `Y` | Copy relative path |
| `gy` | Copy absolute path |
| `R` | Refresh |
| `?` | Show help |

## 🎪 Harpoon (Quick Navigation)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>a` | Normal | Add file to harpoon |
| `<leader>h` | Normal | Toggle harpoon menu |
| `<C-h>` | Normal | Navigate to file 1 |
| `<C-t>` | Normal | Navigate to file 2 |
| `<C-n>` | Normal | Navigate to file 3 |
| `<C-s>` | Normal | Navigate to file 4 |

## 🎨 UI & Interface

### Alpha Dashboard
| Key | Description |
|-----|-------------|
| `f` | Find file |
| `n` | New file |
| `r` | Recent files |
| `g` | Find text |
| `c` | Config |
| `s` | Restore session |
| `l` | Lazy plugin manager |
| `q` | Quit |

### Which-key
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>?` | Normal | Show all keybindings |
| Any prefix + wait | Normal | Show available continuations |

## 🔗 Git Integration

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gg` | Normal | Git status (if configured) |
| `<leader>gc` | Normal | Git commits |
| `<leader>gb` | Normal | Git blame |
| `]c` | Normal | Next git hunk |
| `[c` | Normal | Previous git hunk |

## 🛠️ Development Tools

### Mason (LSP Management)
| Command | Description |
|---------|-------------|
| `:Mason` | Open Mason interface |
| `:MasonUpdate` | Update all packages |
| `:MasonInstall <server>` | Install specific server |

### Lazy (Plugin Management)
| Command | Description |
|---------|-------------|
| `:Lazy` | Open Lazy interface |
| `:Lazy update` | Update all plugins |
| `:Lazy clean` | Remove unused plugins |
| `:Lazy sync` | Update and clean |

## ⚠️ Disabled Keys

To encourage good Vim habits, arrow keys are disabled in normal mode:
- `<left>` → Shows "Use h to move!!"
- `<right>` → Shows "Use l to move!!"
- `<up>` → Shows "Use k to move!!"
- `<down>` → Shows "Use j to move!!"

## 🎨 Customization

### Adding New Keybindings

1. **Core keybindings**: Add to `lua/config/keymaps.lua`
2. **Plugin-specific**: Add to the plugin's configuration file
3. **LSP-specific**: Add to the `on_attach` function in LSP config

### Keymap Format
```lua
vim.keymap.set("mode", "key", "action", { desc = "Description" })
```

### Which-key Integration
To add descriptions for which-key:
```lua
require("which-key").add({
  { "<leader>x", group = "Group Name" },
  { "<leader>xa", desc = "Action Description" },
})
```

---

## 💡 Tips

1. **Use Space as leader**: All main commands start with Space
2. **Alt for window operations**: Alt-based keys for quick window management
3. **Visual feedback**: Many operations show progress or confirmation
4. **Context aware**: Keybindings change based on file type and context
5. **Telescope for everything**: Most "find" operations use Telescope
6. **Which-key guidance**: Press leader and wait to see available options