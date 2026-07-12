-- ============================================================================
-- GLOBAL KEYMAPS (Cleaned, audited, no conflicts)
-- ============================================================================
local map = vim.keymap.set

-- Movement & ESC
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Down (wrap-aware)" })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Up (wrap-aware)" })
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Search & Scroll (centered)
map("n", "n", "nzzzv", { desc = "Next search (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Clear search highlights (<leader>nh)
map("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Clipboard (black hole register)
map("x", "<leader>p", '"_dP', { desc = "Paste over (no yank)" })
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Buffer Management
map("n", "H", "<cmd>BufferLineCyclePrev<cr>", { desc = "Buffer: Previous" })
map("n", "L", "<cmd>BufferLineCycleNext<cr>", { desc = "Buffer: Next" })

-- Window Resizing
map("n", "<C-Up>", ":resize -2<CR>", { silent = true, desc = "Shrink window height" })
map("n", "<C-Down>", ":resize +2<CR>", { silent = true, desc = "Grow window height" })
map("n", "<C-Left>", ":vertical resize +2<CR>", { silent = true, desc = "Grow window width" })
map("n", "<C-Right>", ":vertical resize -2<CR>", { silent = true, desc = "Shrink window width" })

-- Window Nav
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Splits
map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split vertical" })
map("n", "<leader>ws", "<cmd>split<CR>", { desc = "Split horizontal" })

-- Indent & Join (preserve cursor/selection)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- Explorer
map("n", "<leader>W", "<cmd>NvimTreeCollapse<CR>", { desc = "Explorer: Collapse All" })

-- Utilities
map("n", "<leader>pa", function()
    local p = vim.fn.expand("%:p")
    vim.fn.setreg("+", p)
    vim.notify("Copied: " .. p)
end, { desc = "Copy file path" })

-- ============================================================================
-- Word Wrap Toggle (<leader>ww)
-- ============================================================================
map("n", "<leader>ww", function()
    local wrap = not vim.wo.wrap
    vim.wo.wrap = wrap
    vim.wo.linebreak = wrap
    vim.notify("Word wrap: " .. (wrap and "ON" or "OFF"))
end, { desc = "Toggle word wrap" })

-- ============================================================================
-- Manual Format (<leader>cf)
-- ============================================================================
map({ "n", "v" }, "<leader>cf", function()
    require("conform").format({ lsp_fallback = true, async = true, timeout_ms = 1000 })
end, { desc = "Format file" })

-- ============================================================================
-- Toggle diagnostics (<leader>td)
-- ============================================================================
map("n", "<leader>td", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    vim.notify("Diagnostics: " .. (vim.diagnostic.is_enabled() and "ON" or "OFF"))
end, { desc = "Toggle diagnostics" })
