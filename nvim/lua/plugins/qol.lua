-- ============================================================================
-- QOL: flash + grug-far + mini modules + floating terminal + bufferline
-- ============================================================================

-- ============================================================================
-- Flash.nvim (label-based jump — replaces all mouse navigation)
-- ============================================================================
require("flash").setup({})

vim.keymap.set({ "n", "x", "o" }, "s", function()
    require("flash").jump()
end, { desc = "Flash jump" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
    require("flash").treesitter()
end, { desc = "Flash treesitter" })
vim.keymap.set("o", "r", function()
    require("flash").remote()
end, { desc = "Remote flash" })
vim.keymap.set({ "o", "x" }, "R", function()
    require("flash").treesitter_search()
end, { desc = "Treesitter search" })
vim.keymap.set("c", "<C-s>", function()
    require("flash").toggle()
end, { desc = "Toggle flash search" })

-- ============================================================================
-- Bufferline — clean minimal tabs, transparent icon glyphs
-- ============================================================================

-- Helper: read a hex color from any highlight group attribute
local function get_hl(group, attr)
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    if hl and hl[attr] then return string.format("#%06x", hl[attr]) end
    return nil
end

-- Active tab uses NormalFloat bg (same as hover/completion popups) → looks "elevated"
local function active_bg()
    return get_hl("NormalFloat", "bg") or get_hl("Normal", "bg") or "#2a2a2a"
end
local function active_fg()
    return get_hl("NormalFloat", "fg") or get_hl("Normal", "fg") or "#dddddd"
end

-- ─────────────────────────────────────────────────────────────
-- FIX: strip bg from ALL icon highlight groups so they render
-- as clean colored glyphs, not colored boxes / "PNG images"
-- ─────────────────────────────────────────────────────────────
local function strip_icon_bgs()
    local prefixes = { "DevIcon", "MiniIcons" }
    for _, prefix in ipairs(prefixes) do
        for _, name in ipairs(vim.fn.getcompletion(prefix, "highlight")) do
            local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
            if hl and hl.fg then
                vim.api.nvim_set_hl(0, name, { fg = hl.fg, bg = "none" })
            end
        end
    end
end

-- Strip on startup and after every theme change
strip_icon_bgs()
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("IconBgStrip", { clear = true }),
    callback = function() vim.defer_fn(strip_icon_bgs, 15) end,
})

-- ─────────────────────────────────────────────────────────────
-- Bufferline setup
-- ─────────────────────────────────────────────────────────────
local abg = active_bg()
local afg = active_fg()

require("bufferline").setup({
    options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return icon .. count
        end,
        offsets = {
            {
                filetype = "NvimTree",
                text = "Explorer",
                text_align = "center",
                separator = false,
            },
        },
        show_buffer_close_icons = true,
        show_close_icon = false,
        -- No visible separator chars → tabs float with spacing only
        separator_style = { "", "" },
        indicator = { style = "none" },
        modified_icon = "●",
        left_trunc_marker = "…",
        right_trunc_marker = "…",
        max_name_length = 28,
        -- Extra horizontal padding around each label
        tab_size = 24,
        color_icons = true,
        name_formatter = function(buf)
            return "  " .. buf.name .. "  "
        end,
    },
    highlights = {
        -- Tabline filler row: fully transparent
        fill              = { bg = "none" },

        -- Inactive tabs: transparent bg, dimmed text
        background        = { bg = "none", fg = "#606060" },
        buffer_visible    = { bg = "none", fg = "#888888" },
        duplicate         = { bg = "none", fg = "#555555", italic = true },
        duplicate_visible = { bg = "none", fg = "#666666", italic = true },

        -- ACTIVE tab: elevated background matching NormalFloat (popup color)
        buffer_selected   = { bg = abg, fg = afg, bold = true, italic = false },
        duplicate_selected = { bg = abg, fg = afg, italic = true },
        numbers_selected  = { bg = abg, fg = afg, bold = true },
        pick_selected     = { bg = abg, fg = afg, bold = true },

        -- Separators: invisible (empty strings above mean these are unused anyway)
        separator           = { bg = "none", fg = "none" },
        separator_selected  = { bg = "none", fg = "none" },
        separator_visible   = { bg = "none", fg = "none" },

        -- Inactive element bg: transparent
        close_button      = { bg = "none" },
        modified          = { bg = "none" },
        numbers           = { bg = "none" },
        error             = { bg = "none" },
        warning           = { bg = "none" },
        info              = { bg = "none" },
        hint              = { bg = "none" },
        error_diagnostic  = { bg = "none" },
        warning_diagnostic = { bg = "none" },

        -- Active tab: all child elements share elevated bg
        close_button_selected  = { bg = abg },
        modified_selected      = { bg = abg },
        error_selected         = { bg = abg, bold = true },
        warning_selected       = { bg = abg, bold = true },
        info_selected          = { bg = abg },
        hint_selected          = { bg = abg },
        error_diagnostic_selected   = { bg = abg },
        warning_diagnostic_selected = { bg = abg },
    },
})

-- Re-sync bufferline highlights whenever the theme changes
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("BufferlineThemeSync", { clear = true }),
    callback = function()
        vim.defer_fn(function()
            local bg, fg = active_bg(), active_fg()
            local s = vim.api.nvim_set_hl
            s(0, "BufferLineBufferSelected",         { bg = bg, fg = fg, bold = true })
            s(0, "BufferLineDuplicateSelected",       { bg = bg, fg = fg, italic = true })
            s(0, "BufferLineNumbersSelected",         { bg = bg, fg = fg, bold = true })
            s(0, "BufferLinePickSelected",            { bg = bg, fg = fg, bold = true })
            for _, suffix in ipairs({
                "CloseButtonSelected", "ModifiedSelected",
                "ErrorSelected", "WarningSelected", "InfoSelected", "HintSelected",
                "ErrorDiagnosticSelected", "WarningDiagnosticSelected",
            }) do
                s(0, "BufferLine" .. suffix, { bg = bg })
            end
        end, 15)
    end,
})



-- ============================================================================
-- Which-Key (The Helper: Press <leader> to see your keybinds)
-- ============================================================================
local wk = require("which-key")
wk.setup({
    delay = 200,
    win = {
        border = "rounded",
    },
    icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
    },
})

-- Register groups for clean WhichKey display
wk.add({
    { "<leader>b",  group = "Buffer" },
    { "<leader>c",  group = "Code" },
    { "<leader>f",  group = "Find" },
    { "<leader>g",  group = "Git" },
    { "<leader>h",  group = "Hunk" },
    { "<leader>n",  group = "Navigation" },
    { "<leader>s",  group = "Search/Replace" },
    { "<leader>t",  group = "Terminal/Theme" },
    { "<leader>v",  group = "View" },
    { "<leader>w",  group = "Window/Wrap" },
    { "<leader>x",  group = "Trouble" },
})

-- ============================================================================
-- Grug-far (ripgrep project-wide find & replace)
-- ============================================================================
require("grug-far").setup({})

-- Project-wide search
vim.keymap.set("n", "<leader>sr", function()
    require("grug-far").open()
end, { desc = "Search & Replace (project)" })

-- Current file ONLY search
vim.keymap.set("n", "<leader>sf", function()
    require("grug-far").open({
        prefills = { paths = vim.fn.expand("%") }
    })
end, { desc = "Search & Replace (file)" })

-- Search the exact word your cursor is on (Project-wide)
vim.keymap.set("n", "<leader>sw", function()
    require("grug-far").open({
        prefills = { search = vim.fn.expand("<cword>") }
    })
end, { desc = "Search cursor word" })

-- Visual selection search (reads the actual selected text via Neovim marks)
vim.keymap.set("v", "<leader>sr", function()
    -- Exit visual mode first so '</'> marks are set correctly
    vim.cmd([[execute "normal! \<Esc>"]])
    local start = vim.api.nvim_buf_get_mark(0, "<")
    local finish = vim.api.nvim_buf_get_mark(0, ">")
    local lines = vim.api.nvim_buf_get_lines(0, start[1] - 1, finish[1], false)
    if #lines == 0 then return end
    -- Trim to column range for single-line selections
    if #lines == 1 then
        lines[1] = lines[1]:sub(start[2] + 1, finish[2] + 1)
    end
    local selection = table.concat(lines, "\n")
    require("grug-far").open({ prefills = { search = selection } })
end, { desc = "Search selection" })

-- ============================================================================
-- Mini modules
-- ============================================================================
require("mini.ai").setup({})       -- enhanced text objects (va), vif, etc)
require("mini.surround").setup({}) -- add/change/delete surroundings (sa, sd, sr)
require("mini.move").setup({})     -- move lines/selections with Alt+h/j/k/l
require("mini.cursorword").setup({})   -- highlight word under cursor
require("mini.indentscope").setup({})  -- animated indent scope line
require("mini.pairs").setup({})        -- auto-pairs
require("mini.trailspace").setup({})   -- highlight trailing whitespace
require("mini.bufremove").setup({})    -- safe buffer removal
require("mini.notify").setup({})       -- minimal notification system
require("mini.splitjoin").setup({})    -- toggle single-line ↔ multi-line (gS)

-- Buffer delete
vim.keymap.set("n", "<leader>bd", function()
    require("mini.bufremove").delete(0, false)
end, { desc = "Delete buffer" })

-- ============================================================================
-- Floating terminal (preserved from original config)
-- ============================================================================
local terminal_state = { buf = nil, win = nil, is_open = false }

local function FloatingTerminal()
    if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
        return
    end

    if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
        terminal_state.buf = vim.api.nvim_create_buf(false, true)
        vim.bo[terminal_state.buf].bufhidden = "hide"
    end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    vim.wo[terminal_state.win].winblend = 0
    vim.wo[terminal_state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
    vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

    if vim.bo[terminal_state.buf].buftype ~= "terminal" then
        vim.fn.termopen(os.getenv("SHELL"))
    end

    terminal_state.is_open = true
    vim.cmd("startinsert")

    local term_augroup = vim.api.nvim_create_augroup("FloatingTermLeave_" .. terminal_state.win, { clear = true })
    vim.api.nvim_create_autocmd("BufLeave", {
        group = term_augroup,
        buffer = terminal_state.buf,
        callback = function()
            if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
                vim.api.nvim_win_close(terminal_state.win, false)
                terminal_state.is_open = false
            end
        end,
        once = true,
    })
end

vim.keymap.set("n", "<leader>tt", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Terminal normal mode" })
vim.keymap.set("t", "<C-q>", function()
    if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
    end
end, { noremap = true, silent = true, desc = "Close floating terminal" })
