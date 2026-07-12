-- ============================================================================
-- DIAGNOSTICS: config + trouble.nvim + distinct underline styles
-- ============================================================================

-- Diagnostic signs (icons only, no virtual text)
local signs = {
    Error = "\u{f057} ",
    Warn  = "\u{f071} ",
    Hint  = "\u{ea61}",
    Info  = "\u{f05a}",
}

vim.diagnostic.config({
    virtual_text = false, -- NO inline virtual text
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.INFO] = signs.Info,
            [vim.diagnostic.severity.HINT] = signs.Hint,
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
        focusable = true,
        style = "minimal",
    },
})

-- ============================================================================
-- Distinct diagnostic underlines (re-applied on every colorscheme change)
-- ============================================================================
local function apply_diagnostic_highlights()
    -- Errors: red undercurl (squiggly)
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
        undercurl = true,
        sp = "#db4b4b",
    })
    -- Warnings: yellow undercurl (squiggly)
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {
        undercurl = true,
        sp = "#e0af68",
    })
    -- Hints: dotted underline
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {
        underdotted = true,
        sp = "#1abc9c",
    })
    -- Info: blue underline (straight)
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {
        underline = true,
        sp = "#0db9d7",
    })

    -- LSP reference highlights: subtle background instead of underline
    -- This prevents confusion with diagnostic underlines
    vim.api.nvim_set_hl(0, "LspReferenceText", {
        bg = "#2a2a3a",
        underline = false,
    })
    vim.api.nvim_set_hl(0, "LspReferenceRead", {
        bg = "#2a3a2a",
        underline = false,
    })
    vim.api.nvim_set_hl(0, "LspReferenceWrite", {
        bg = "#3a2a2a",
        underline = false,
    })

    -- Also link MiniCursorword to a subtle style
    vim.api.nvim_set_hl(0, "MiniCursorword", {
        bg = "#2a2a3a",
        underline = false,
    })
    vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", {
        bg = "#2a2a3a",
        underline = false,
    })
end

-- Apply now and on every colorscheme change
apply_diagnostic_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("DiagnosticHighlights", { clear = true }),
    callback = apply_diagnostic_highlights,
})

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float({ scope = "line" })
end, { desc = "Show line diagnostics (hover)" })

vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })

-- ============================================================================
-- Trouble.nvim (toggleable diagnostic list)
-- ============================================================================
require("trouble").setup({
    focus = true,
    win = { size = 10 },
})

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Workspace diagnostics" })
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix list" })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location list" })
vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle<cr>", { desc = "Document symbols" })
