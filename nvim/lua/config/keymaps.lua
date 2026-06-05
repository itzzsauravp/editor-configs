-- =============================================================================
-- KEYMAPS CONFIGURATION
-- =============================================================================
--
-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                        MASTER KEYBIND REFERENCE                        ║
-- ╠══════════════════════════════════════════════════════════════════════════╣
-- ║                                                                        ║
-- ║  GENERAL:                                                              ║
-- ║    jk              Exit Insert mode (instead of reaching for Esc)       ║
-- ║    <C-s>           Save file (works in Normal, Insert, Visual)          ║
-- ║    <C-z>           Undo                                                 ║
-- ║    <C-S-z>         Redo                                                 ║
-- ║    <leader>uw      Toggle word wrap                                     ║
-- ║    <leader>df      Show line diagnostics (press again to enter float)   ║
-- ║                                                                        ║
-- ║  LINE MOVEMENT (VS Code Alt+Arrow):                                    ║
-- ║    <A-j>           Move current line down (Normal mode)                 ║
-- ║    <A-k>           Move current line up (Normal mode)                   ║
-- ║    <A-j>           Move selected lines down (Visual mode)               ║
-- ║    <A-k>           Move selected lines up (Visual mode)                 ║
-- ║                                                                        ║
-- ║  VISUAL MODE TWEAKS:                                                   ║
-- ║    < / >           Indent/outdent and keep selection active             ║
-- ║    p (in visual)   Paste without overwriting clipboard                  ║
-- ║                                                                        ║
-- ║  DUPLICATE LINES (VS Code Ctrl+Shift+Alt+Arrow):                      ║
-- ║    <leader>j       Duplicate current line below                         ║
-- ║    <leader>k       Duplicate current line above                         ║
-- ║                                                                        ║
-- ║  BUFFER MANAGEMENT:                                                    ║
-- ║    <S-h>           Previous buffer (already from LazyVim)               ║
-- ║    <S-l>           Next buffer (already from LazyVim)                   ║
-- ║    <leader>bd      Delete buffer (already from LazyVim)                 ║
-- ║    <leader>bo      Close all other buffers                              ║
-- ║                                                                        ║
-- ║  SPLITS:                                                               ║
-- ║    <leader>|       Vertical split                                       ║
-- ║    <leader>-       Horizontal split                                     ║
-- ║    <C-h/j/k/l>    Navigate between splits (already from LazyVim)       ║
-- ║                                                                        ║
-- ║  GIT WORKFLOW:                                                         ║
-- ║    <leader>gg      LazyGit (full TUI)                                   ║
-- ║    <leader>gl      Git graph (Flog)                                     ║
-- ║    <leader>gd      Diffview (VS Code style diffs)                       ║
-- ║    <leader>gh      File history (current file)                          ║
-- ║                                                                        ║
-- ║  SEARCH & REPLACE:                                                     ║
-- ║    <leader>sr      Search & replace in current file                     ║
-- ║    <leader>sx      Search & replace across project                      ║
-- ║                                                                        ║
-- ║  SESSIONS:                                                             ║
-- ║    <leader>qs      Restore session for current directory                ║
-- ║    <leader>ql      Restore last session                                 ║
-- ║                                                                        ║
-- ║  TERMINAL (see toggleterm.lua for full terminal cheatsheet):            ║
-- ║    <C-\>           Toggle default terminal                              ║
-- ║    <leader>tt      Toggle terminal (horizontal)                         ║
-- ║    <leader>tf      Toggle floating terminal                             ║
-- ║    <leader>td      LazyDocker (Docker TUI)                              ║
-- ║                                                                        ║
-- ║  DATABASE (see database.lua for full database cheatsheet):             ║
-- ║    <leader>db      Toggle DB UI (connection manager + query editor)     ║
-- ║    <leader>da      Add a new database connection                        ║
-- ║    <leader>de      Execute query (Normal or Visual)                     ║
-- ║    <leader>df      Find DB buffer                                       ║
-- ║    <leader>dw      Save query                                           ║
-- ║                                                                        ║
-- ║  LAZYVIM BUILT-IN (most useful ones you should know):                  ║
-- ║    <leader><space> Find files (like Ctrl+P in VS Code)                  ║
-- ║    <leader>/       Live grep (search in all files)                      ║
-- ║    <leader>e       File explorer (Neo-tree)                             ║
-- ║    <leader>:       Command palette                                      ║
-- ║    <leader>?       Recently opened files                                ║
-- ║    <leader>xx      Toggle Trouble (diagnostics list)                    ║
-- ║    K               Show hover documentation (on any symbol)             ║
-- ║    gd              Go to definition                                     ║
-- ║    gr              Go to references                                     ║
-- ║    <leader>ca      Code action                                          ║
-- ║    <leader>cr      Rename symbol                                        ║
-- ║                                                                        ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
-- =============================================================================

local map = vim.keymap.set

-- =============================================================================
-- 1. GENERAL / MODE SWITCHING
-- =============================================================================

-- Exit Insert mode with jk (saves reaching for Esc)
map("i", "jk", "<ESC>", { desc = "Exit Insert Mode" })

-- Save with Ctrl+S (works everywhere, like VS Code)
map({ "n", "i", "v", "s" }, "<C-s>", "<Cmd>w<CR><Esc>", { desc = "Save File" })

-- Undo / Redo (VS Code style)
map("n", "<C-z>", "u", { desc = "Undo" })
map("n", "<C-S-z>", "<C-r>", { desc = "Redo" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo" })
map("i", "<C-S-z>", "<C-o><C-r>", { desc = "Redo" })

-- =============================================================================
-- 2. UI TOGGLES
-- =============================================================================

-- Toggle Word Wrap
map("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
  print("Word wrap: " .. (vim.wo.wrap and "On" or "Off"))
end, { desc = "Toggle Word Wrap" })

-- Line Diagnostics (press once to see, press again to enter the float)
map("n", "<leader>df", function()
  vim.diagnostic.open_float({
    scope = "line",
    focusable = true,
    border = "rounded",
  })
end, { desc = "Show Line Diagnostics" })

-- =============================================================================
-- 3. LINE MOVEMENT & DUPLICATION (VS Code Alt+Arrow / Ctrl+Shift+Alt+Arrow)
-- =============================================================================

-- Move lines up/down with Alt+j/k (Normal mode)
map("n", "<A-j>", "<Cmd>m .+1<CR>==", { desc = "Move Line Down" })
map("n", "<A-k>", "<Cmd>m .-2<CR>==", { desc = "Move Line Up" })

-- Move selected lines up/down with Alt+j/k (Visual mode)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move Selection Down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move Selection Up" })

-- Duplicate line down/up (like Ctrl+Shift+Alt+Arrow in VS Code)
map("n", "<leader>j", "<Cmd>t.<CR>", { desc = "Duplicate Line Below" })
map("n", "<leader>k", "<Cmd>t.-1<CR>", { desc = "Duplicate Line Above" })

-- =============================================================================
-- 4. VISUAL MODE TWEAKS
-- =============================================================================

-- Better Indenting: Keeps the selection active after shifting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- "Black Hole" Paste: Prevents overwriting your clipboard when pasting over text
-- This allows you to paste the same thing multiple times in different places
map("x", "p", [["_dP]])

-- =============================================================================
-- 5. BUFFER MANAGEMENT
-- =============================================================================

-- Close all other buffers (keep only the current one)
map("n", "<leader>bo", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      local buftype = vim.bo[buf].buftype
      -- Don't close terminal or special buffers
      if buftype ~= "terminal" and buftype ~= "nofile" then
        vim.api.nvim_buf_delete(buf, { force = false })
      end
    end
  end
  vim.notify("Closed other buffers", vim.log.levels.INFO)
end, { desc = "Close Other Buffers" })

-- =============================================================================
-- 6. GIT WORKFLOW
-- =============================================================================

-- LazyGit Dashboard
map("n", "<leader>gg", "<Cmd>LazyGit<CR>", { desc = "LazyGit" })

-- Git Graph (Flog)
map("n", "<leader>gl", "<Cmd>Flogsplit<CR>", { desc = "Git Graph (Flog)" })

-- Diffview (VS Code Style Diffs)
map("n", "<leader>gd", "<Cmd>DiffviewOpen<CR>", { desc = "Diffview Open" })
map("n", "<leader>gh", "<Cmd>DiffviewFileHistory %<CR>", { desc = "File History" })

-- =============================================================================
-- 7. SEARCH & REPLACE (Grug-far)
-- =============================================================================

-- Project-wide search and replace
map("n", "<leader>sR", function()
  require("grug-far").open({})
end, { desc = "Search & Replace (Project)" })

-- Current file search and replace
map("n", "<leader>sr", function()
  require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
end, { desc = "Search & Replace (Current File)" })

-- =============================================================================
-- 8. SESSION MANAGEMENT
-- =============================================================================

-- Restore session for the current directory
map("n", "<leader>qs", function()
  require("persistence").load()
end, { desc = "Restore Session" })

-- Restore the last session Neovim had open
map("n", "<leader>ql", function()
  require("persistence").load({ last = true })
end, { desc = "Restore Last Session" })
