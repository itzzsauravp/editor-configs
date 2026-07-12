-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Restore last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    desc = "Restore last cursor position",
    callback = function()
        if vim.o.diff then
            return
        end
        local last_pos = vim.api.nvim_buf_get_mark(0, '"')
        local last_line = vim.api.nvim_buf_line_count(0)
        if last_pos[1] >= 1 and last_pos[1] <= last_line then
            pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
        end
    end,
})

-- Wrap, linebreak and spellcheck for prose filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
    end,
})

-- Terminal: clean UI on open
vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
    end,
})

-- Terminal: auto-close buffer on clean exit
vim.api.nvim_create_autocmd("TermClose", {
    group = augroup,
    callback = function()
        if vim.v.event.status == 0 then
            vim.api.nvim_buf_delete(0, {})
        end
    end,
})

-- ============================================================================
-- FIX: Markdown hover rendering bug
-- When focusing the hover window (which has filetype "markdown"), Neovim
-- renders the buffer in "editing mode" showing raw markdown. Setting
-- conceallevel to 2 and concealcursor to "nvc" keeps it rendered properly.
-- ============================================================================
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "markdown",
    callback = function(args)
        -- Only apply to floating windows (hover docs, etc.)
        local wins = vim.fn.win_findbuf(args.buf)
        for _, win in ipairs(wins) do
            local cfg = vim.api.nvim_win_get_config(win)
            if cfg.relative and cfg.relative ~= "" then
                vim.api.nvim_set_option_value("conceallevel", 2, { win = win })
                vim.api.nvim_set_option_value("concealcursor", "nvc", { win = win })
            end
        end
        -- Also set buffer-local defaults that apply when entering floating windows
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = "nvc"
    end,
})

-- Re-apply conceallevel when entering a floating window with markdown
vim.api.nvim_create_autocmd("WinEnter", {
    group = augroup,
    callback = function()
        local cfg = vim.api.nvim_win_get_config(0)
        if cfg.relative and cfg.relative ~= "" then
            if vim.bo.filetype == "markdown" then
                vim.opt_local.conceallevel = 2
                vim.opt_local.concealcursor = "nvc"
            end
        end
    end,
})
