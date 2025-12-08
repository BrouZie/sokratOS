---
id: neovim-keybinds
title: Neovim Keybinds
tags: [neovim, keybinds, editor, vim]
---

# Neovim Keybinds

Complete reference for Neovim keybindings in sokratOS.

## Leader Key

sokratOS uses **`Space`** as the leader key:

```lua
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
```

**Why Space?**
- Easy to reach with either thumb
- Mnemonic: "space" for commands
- Doesn't conflict with vim default motions

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` line 1

## How to Use Leader Keybinds

Leader keybinds require pressing leader first:

1. Press `Space` (leader)
2. Press the command key(s)

Example: `<leader>w` means press `Space`, then `w`

## Essential Keybinds

### File Operations

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>e` | Open file explorer | Launch Oil.nvim file browser |
| `<leader>w` | Save file | Write current buffer to disk |
| `<leader>q` | Quit | Close current window |
| `<leader>b` | Alternate file | Switch to previously edited file |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` lines 9-12

**Mnemonics**:
- `e` = Explorer
- `w` = Write
- `q` = Quit
- `b` = Back/Buffer

### Window/Split Management

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>v` | Vertical split | Create vertical split |
| `<leader>s` | Horizontal split | Create horizontal split |
| `<leader>S` | Split alternate | Open alternate file in horizontal split |
| `<leader>V` | Vsplit alternate | Open alternate file in vertical split |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` lines 13-14, 22-23

### Window Resizing

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>+` | Grow width | Increase vertical split width by 5 |
| `<leader>-` | Shrink width | Decrease vertical split width by 5 |
| `<leader>?` | Grow height | Increase horizontal split height by 5 |
| `<leader>_` | Shrink height | Decrease horizontal split height by 5 |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` lines 24-27

### Window Navigation

| Keybind | Action | Description |
|---------|--------|-------------|
| `Ctrl-h` | Focus left | Move to window/pane on the left |
| `Ctrl-j` | Focus down | Move to window/pane below |
| `Ctrl-k` | Focus up | Move to window/pane above |
| `Ctrl-l` | Focus right | Move to window/pane on the right |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` lines 33-36

**Note**: These also work with tmux panes thanks to tmux navigation plugin!

## Navigation and Movement

### Smooth Scrolling

| Keybind | Action | Description |
|---------|--------|-------------|
| `Ctrl-d` | Scroll down | Half-page down, cursor centered |
| `Ctrl-u` | Scroll up | Half-page up, cursor centered |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` lines 17-18

**Why `zz`?** Keeps cursor in middle of screen for better visibility.

### Search

| Keybind | Action | Description |
|---------|--------|-------------|
| `<Esc>` | Clear highlights | Remove search highlighting |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` line 37

## Editing

### Visual Mode Line Movement

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `J` | Visual | Move lines down | Move selected lines down |
| `K` | Visual | Move lines up | Move selected lines up |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` lines 44-45

**How it works**: Select lines in visual mode, press `J` or `K` to move them.

### Indentation

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<` | Visual | Dedent | Decrease indentation |
| `>` | Visual | Indent | Increase indentation |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` lines 40-41

**Feature**: Stays in visual mode after indenting (normally exits visual mode).

### Find and Replace

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>rp` | Replace word | Replace word under cursor in buffer |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` lines 58-62

**How it works**:
1. Place cursor on word to replace
2. Press `<leader>rp`
3. Type new word
4. Press Enter or use `n` to skip occurrences

## Git Integration

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>Gs` | Git status | Open fugitive status window |
| `<leader>GG` | Git command | Open git command prompt |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` lines 7-8

**Usage**:
- `<leader>Gs`: Opens git status, stage/unstage with `-`, commit with `cc`
- `<leader>GG`: Type git commands like `commit`, `push`, etc.

## Code Features

### LSP (Language Server)

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>lx` | Toggle diagnostics | Show/hide LSP error messages |
| `<leader>H` | Toggle inlay hints | Show/hide type hints and parameter names |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` lines 71-73, 77-83

**Additional LSP keybinds** (configured by LSP plugins):
- `gd` - Go to definition
- `gr` - Find references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol

### GitHub Copilot

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `Ctrl-F` | Insert | Accept suggestion | Accept Copilot completion |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` lines 65-68

**How Copilot works**:
1. Start typing code
2. Gray suggestion appears
3. Press `Ctrl-F` to accept
4. Press `Ctrl-]` to dismiss

## Utilities

### Directory Navigation

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>cd` | Change directory | Set vim working directory to current file |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` line 30

**Use case**: When you open vim from wrong directory.

### File Path

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>yp` | Copy file path | Copy relative file path to clipboard |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` lines 48-52

**Use case**: Sharing file locations, documentation, issue reports.

### Colorizer

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>c` | Toggle colorizer | Show/hide color preview for color codes |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` line 55

**What it does**: Shows color preview for hex codes like `#FF0000` or rgb values.

## Plugin-Specific Keybinds

These keybinds are defined by plugins installed in sokratOS neovim config:

### Telescope (Fuzzy Finder)

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>ff` | Find files | Search files in project |
| `<leader>fg` | Live grep | Search text in files |
| `<leader>fb` | Find buffers | Search open buffers |
| `<leader>fh` | Find help | Search help docs |
| `<leader>E` | Environment vars | Browse environment variables |
| `<leader>ts` | TODO search | Find TODO comments |

**Plugin**: telescope.nvim

### Todo Comments

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>ts` | Todo Telescope | Search all TODO comments |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` line 6

**Searches for**: `TODO:`, `FIXME:`, `HACK:`, `NOTE:`, etc.

### Terminal Mode

| Keybind | Mode | Action | Description |
|---------|------|--------|-------------|
| `<Esc><Esc>` | Terminal | Exit insert | Return to normal mode in terminal |

**Defined in**: `~/.config/nvim/lua/brouzie/core/keymaps.lua` lines 15-16

**Use case**: Escape terminal insert mode without closing terminal.

## Vim Default Keybinds (Essential)

These are standard vim keybinds worth knowing:

### Modes

| Keybind | Action | Description |
|---------|--------|-------------|
| `i` | Insert mode | Start inserting before cursor |
| `a` | Append mode | Start inserting after cursor |
| `I` | Insert at line start | Move to start of line and insert |
| `A` | Append at line end | Move to end of line and insert |
| `o` | Open line below | Create new line below and insert |
| `O` | Open line above | Create new line above and insert |
| `v` | Visual mode | Character-wise visual selection |
| `V` | Visual line | Line-wise visual selection |
| `Ctrl-v` | Visual block | Block-wise visual selection |
| `Esc` or `Ctrl-[` | Normal mode | Return to normal mode |

### Movement

| Keybind | Action | Description |
|---------|--------|-------------|
| `h/j/k/l` | Basic movement | Left/Down/Up/Right |
| `w` | Word forward | Next word start |
| `b` | Word backward | Previous word start |
| `e` | Word end | End of current word |
| `0` | Line start | Beginning of line |
| `^` | First non-blank | First non-whitespace character |
| `$` | Line end | End of line |
| `gg` | File start | First line of file |
| `G` | File end | Last line of file |
| `{` / `}` | Paragraph | Previous/next paragraph |
| `%` | Matching bracket | Jump to matching bracket |

### Editing

| Keybind | Action | Description |
|---------|--------|-------------|
| `x` | Delete char | Delete character under cursor |
| `dd` | Delete line | Delete current line |
| `d<motion>` | Delete | Delete with motion (e.g., `dw`, `d$`) |
| `yy` | Yank line | Copy current line |
| `y<motion>` | Yank | Copy with motion (e.g., `yw`) |
| `p` | Paste after | Paste after cursor/line |
| `P` | Paste before | Paste before cursor/line |
| `u` | Undo | Undo last change |
| `Ctrl-r` | Redo | Redo undone change |
| `.` | Repeat | Repeat last change |

### Search

| Keybind | Action | Description |
|---------|--------|-------------|
| `/pattern` | Search forward | Search for pattern forward |
| `?pattern` | Search backward | Search for pattern backward |
| `n` | Next match | Next search result |
| `N` | Previous match | Previous search result |
| `*` | Search word forward | Search word under cursor |
| `#` | Search word backward | Search word under cursor backward |

## Oil.nvim File Browser

When you press `<leader>e`, Oil opens:

| Keybind | Action | Description |
|---------|--------|-------------|
| `<CR>` (Enter) | Open | Open file or directory |
| `-` | Parent directory | Go up one level |
| `_` | Current directory | Open actions menu |
| `g?` | Help | Show Oil help |

**Creating files/directories**:
1. Press `<leader>e` to open Oil
2. Press `i` to insert mode
3. Type new filename
4. Press `<CR>` to create

## Customizing Neovim Keybinds

### Add Your Own Keybinds

Edit `~/.config/nvim/lua/brouzie/core/keymaps.lua`:

```lua
local map = vim.keymap.set

-- Add your custom keybinds
map("n", "<leader>t", ":terminal<CR>", { desc = "Open terminal" })
map("n", "<leader>h", ":nohl<CR>", { desc = "Clear highlights" })
map("n", "<leader>m", ":Mason<CR>", { desc = "Open Mason" })
```

### Keybind Syntax

```lua
vim.keymap.set(mode, lhs, rhs, opts)

-- mode: "n" (normal), "i" (insert), "v" (visual), "t" (terminal)
-- lhs: Left-hand side (the keys you press)
-- rhs: Right-hand side (what happens)
-- opts: Optional table with desc, silent, noremap, etc.
```

**Examples**:

```lua
-- Simple command
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- With description
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- Call lua function
vim.keymap.set("n", "<leader>x", function()
    print("Hello from keybind!")
end)

-- Insert mode mapping
vim.keymap.set("i", "jk", "<Esc>")
```

## Plugin-Specific Configurations

Plugins define their own keybinds in separate files:

**Telescope**: `~/.config/nvim/lua/brouzie/plugins/telescope.lua`
**LSP**: `~/.config/nvim/lua/brouzie/plugins/lsp.lua`
**Colorizer**: `~/.config/nvim/lua/brouzie/plugins/colorizer.lua`

Check individual plugin configs for their keybinds.

## Learning Strategy

### Week 1: Essential Motions
- `h/j/k/l` - Basic movement
- `i/a` - Insert/append
- `Esc` - Return to normal mode
- `:w` - Save
- `:q` - Quit

### Week 2: File Management
- `<leader>e` - File explorer
- `<leader>w` - Save
- `<leader>q` - Quit
- `<leader>b` - Alternate file

### Week 3: Editing
- `dd` - Delete line
- `yy` - Yank line
- `p` - Paste
- `u` - Undo
- `.` - Repeat

### Week 4: Advanced
- Visual mode movements
- Search and replace
- Window management
- Git integration

## Troubleshooting

### Keybind Not Working

1. **Check if mapped**:
   ```vim
   :map <leader>w
   ```

2. **Check leader key**:
   ```vim
   :echo mapleader
   ```
   Should output ` ` (space).

3. **Reload config**:
   ```vim
   :source ~/.config/nvim/init.lua
   ```

### Leader Key Not Working

If `<leader>` keybinds don't work:

1. **Leader must be set before using it**
   - Check `~/.config/nvim/lua/brouzie/core/keymaps.lua` line 1
   - Must be set before any mappings that use it

2. **Try explicit space**:
   ```vim
   :map <Space>w
   ```

### Plugin Keybinds Not Working

1. **Check plugin is installed**:
   ```vim
   :Lazy
   ```

2. **Check plugin is loaded**:
   ```vim
   :Lazy health
   ```

3. **Check plugin config** in `~/.config/nvim/lua/brouzie/plugins/`

## Next Steps

- **[Terminal Workflow](../03-workflows/terminal-workflow.md)** - Tmux + Neovim integration
- **[Coding Workflow](../03-workflows/coding-workflow.md)** - Development tips
- **[File Locations](../05-reference/file-locations.md)** - Where configs live
- **[Scripts Reference](../05-reference/scripts.md)** - Custom utilities

## Additional Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Learn Vim Progressively](http://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/)
- [Vim Cheat Sheet](https://vim.rtorr.com/)
- [Oil.nvim GitHub](https://github.com/stevearc/oil.nvim)
