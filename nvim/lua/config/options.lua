-- =============================================================================
-- NEOVIM OPTIONS
-- =============================================================================
-- These are loaded BEFORE lazy.nvim startup.
-- Default options from LazyVim: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
--
-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                          OPTIONS REFERENCE                             ║
-- ╠══════════════════════════════════════════════════════════════════════════╣
-- ║                                                                        ║
-- ║  WHAT THESE DO:                                                        ║
-- ║    • Relative line numbers — quick jumping (e.g., 12j to go 12 down)   ║
-- ║    • Auto-save on focus lost — never lose work                          ║
-- ║    • Splits open right/below — feels natural (like VS Code)             ║
-- ║    • Smooth scrolling — modern feel                                     ║
-- ║    • Persistent undo — undo even after closing and reopening a file     ║
-- ║    • Better search — case-insensitive unless you use uppercase          ║
-- ║    • Cursor line — highlights the line your cursor is on                ║
-- ║                                                                        ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
-- =============================================================================

local opt = vim.opt

-- =============================================================================
-- Line Numbers
-- =============================================================================
opt.number = true -- Show current line number
opt.relativenumber = true -- Show relative line numbers (for quick jumps like 5j, 12k)

-- =============================================================================
-- Cursor & Visual Feedback
-- =============================================================================
opt.cursorline = true -- Highlight the line the cursor is on
opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor when scrolling
opt.sidescrolloff = 8 -- Keep 8 columns visible left/right when scrolling
opt.signcolumn = "yes" -- Always show the sign column (prevents layout shift)
opt.termguicolors = true -- Full color support (24-bit)

-- =============================================================================
-- Splits (open right and below, like VS Code)
-- =============================================================================
opt.splitright = true -- Vertical splits open to the right
opt.splitbelow = true -- Horizontal splits open below

-- =============================================================================
-- Search
-- =============================================================================
opt.ignorecase = true -- Case-insensitive search...
opt.smartcase = true -- ...unless you type an uppercase letter

-- =============================================================================
-- Tabs & Indentation
-- =============================================================================
opt.tabstop = 2 -- Tab width = 2 spaces
opt.shiftwidth = 2 -- Indent width = 2 spaces
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Auto-indent new lines

-- =============================================================================
-- Undo & Backup
-- =============================================================================
opt.undofile = true -- Persistent undo (survives closing/reopening files)
opt.undolevels = 10000 -- Maximum number of undo steps
opt.swapfile = false -- No swap files (auto-save handles this)
opt.backup = false -- No backup files (use git instead)

-- =============================================================================
-- Auto-save on focus lost
-- =============================================================================
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  group = vim.api.nvim_create_augroup("autosave", { clear = true }),
  pattern = "*",
  callback = function()
    -- Only save if the buffer is modified, has a filename, and is a normal buffer
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
    end
  end,
  desc = "Auto-save on focus lost",
})

-- =============================================================================
-- Clipboard (use system clipboard)
-- =============================================================================
opt.clipboard = "unnamedplus" -- Yank/paste uses system clipboard

-- =============================================================================
-- Performance
-- =============================================================================
opt.updatetime = 200 -- Faster CursorHold (for diagnostics, git signs)
opt.timeoutlen = 300 -- Faster key sequence completion (which-key shows faster)

-- =============================================================================
-- Wrapping
-- =============================================================================
opt.wrap = false -- No line wrapping by default (toggle with <leader>uw)
opt.linebreak = true -- When wrap is on, break at word boundaries
