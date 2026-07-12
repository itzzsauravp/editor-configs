-- ============================================================================
-- GIT: gitsigns + mini.git + lazygit + fzf-lua git
-- ============================================================================

-- Gitsigns (standard keymaps from gitsigns README)
require("gitsigns").setup({
    signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "▎" },
        topdelete    = { text = "▎" },
        changedelete = { text = "▎" },
    },
    on_attach = function(bufnr)
        local gs = require("gitsigns")

        local function opts(desc)
            return { buffer = bufnr, desc = desc }
        end

        -- Navigation (standard: ]c / [c)
        vim.keymap.set("n", "]c", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gs.nav_hunk("next")
            end)
            return "<Ignore>"
        end, { buffer = bufnr, expr = true, desc = "Next hunk" })

        vim.keymap.set("n", "[c", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gs.nav_hunk("prev")
            end)
            return "<Ignore>"
        end, { buffer = bufnr, expr = true, desc = "Prev hunk" })

        -- Actions (standard gitsigns bindings)
        vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts("Stage hunk"))
        vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts("Reset hunk"))
        vim.keymap.set("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, opts("Stage hunk (visual)"))
        vim.keymap.set("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, opts("Reset hunk (visual)"))
        vim.keymap.set("n", "<leader>hS", gs.stage_buffer, opts("Stage buffer"))
        vim.keymap.set("n", "<leader>hR", gs.reset_buffer, opts("Reset buffer"))
        vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, opts("Undo stage hunk"))
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts("Preview hunk"))
        vim.keymap.set("n", "<leader>hb", function()
            gs.blame_line({ full = true })
        end, opts("Blame line (full)"))
        vim.keymap.set("n", "<leader>hd", gs.diffthis, opts("Diff this"))
        vim.keymap.set("n", "<leader>hD", function()
            gs.diffthis("~")
        end, opts("Diff this ~"))

        -- Toggles
        vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, opts("Toggle line blame"))
        vim.keymap.set("n", "<leader>tD", gs.toggle_deleted, opts("Toggle deleted"))
    end,
})

-- Mini.git (show_at_cursor for full commit detail)
require("mini.git").setup({})

vim.keymap.set("n", "<leader>gB", function()
    require("mini.git").show_at_cursor()
end, { desc = "Git show at cursor (full commit)" })

-- ============================================================================
-- Lazygit (custom float — no extra plugin needed)
-- ============================================================================
local lazygit_state = { buf = nil, win = nil }

local function open_lazygit()
    if vim.fn.executable("lazygit") ~= 1 then
        vim.notify("lazygit not found in PATH", vim.log.levels.ERROR)
        return
    end

    local width = math.floor(vim.o.columns * 0.9)
    local height = math.floor(vim.o.lines * 0.9)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    lazygit_state.buf = vim.api.nvim_create_buf(false, true)

    lazygit_state.win = vim.api.nvim_open_win(lazygit_state.buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    vim.fn.termopen("lazygit", {
        on_exit = function()
            if lazygit_state.win and vim.api.nvim_win_is_valid(lazygit_state.win) then
                vim.api.nvim_win_close(lazygit_state.win, true)
            end
            if lazygit_state.buf and vim.api.nvim_buf_is_valid(lazygit_state.buf) then
                vim.api.nvim_buf_delete(lazygit_state.buf, { force = true })
            end
            lazygit_state = { buf = nil, win = nil }
        end,
    })

    vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>gg", open_lazygit, { desc = "Open Lazygit" })

-- ============================================================================
-- Git via fzf-lua (status, branches, log, stash)
-- ============================================================================
vim.keymap.set("n", "<leader>gs", function()
    require("fzf-lua").git_status()
end, { desc = "Git status" })

vim.keymap.set("n", "<leader>gb", function()
    require("fzf-lua").git_branches()
end, { desc = "Git branches" })

vim.keymap.set("n", "<leader>gl", function()
    require("fzf-lua").git_commits()
end, { desc = "Git log (all commits)" })

vim.keymap.set("n", "<leader>gL", function()
    require("fzf-lua").git_bcommits()
end, { desc = "Git log (buffer commits)" })

vim.keymap.set("n", "<leader>gS", function()
    require("fzf-lua").git_stash()
end, { desc = "Git stash" })
