-- ============================================================================
-- UI: mini.icons + nvim-tree + fzf-lua
-- ============================================================================

-- Mini icons (must load first — provides nvim-web-devicons compatibility)
require("mini.icons").setup({})
MiniIcons.mock_nvim_web_devicons()

-- Nvim-tree (sidebar file explorer)
require("nvim-tree").setup({
    view = { width = 35 },
    filters = { dotfiles = false },
    renderer = {
        group_empty = true,
        -- Show only the folder name, not the full path
        root_folder_label = ":t",
    },
    -- Disable navigating to parent when pressing Enter on root
    actions = {
        change_dir = {
            enable = false,
            restrict_above_cwd = true,
        },
    },
    -- Prevent entering parent directory
    update_focused_file = {
        enable = true,
        update_root = false,
    },
})

vim.keymap.set("n", "<leader>e", function()
    require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle file tree" })

-- Transparent nvim-tree
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeSignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#2a2a2a", bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })

-- fzf-lua (fzf-native profile for max speed)
require("fzf-lua").setup({
    "fzf-native",
    winopts = {
        border = "rounded",
        preview = {
            border = "rounded",
        },
    },
    keymap = {
        -- These keymaps apply specifically to the fzf terminal prompt
        fzf = {
            ["ctrl-j"] = "down",               -- Move down the list
            ["ctrl-k"] = "up",                 -- Move up the list
            ["ctrl-d"] = "preview-page-down",  -- Scroll preview down
            ["ctrl-u"] = "preview-page-up",    -- Scroll preview up
        },
    },
    actions = {
        -- Global action to copy the selected item from the list to your clipboard
        -- Works across files, git commits, etc.
        ["default"] = require("fzf-lua.actions").file_edit,
        ["ctrl-y"] = function(selected)
            if selected and selected[1] then
                -- Extract the raw text without the fzf formatting/icons
                local text = selected[1]:match("([^:]+)") or selected[1]
                vim.fn.setreg("+", text)
                vim.notify("Copied to clipboard: " .. text)
            end
        end,
    },
})

vim.keymap.set("n", "<leader>ff", function() require("fzf-lua").files() end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function() require("fzf-lua").live_grep() end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", function() require("fzf-lua").buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", function() require("fzf-lua").help_tags() end, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fr", function() require("fzf-lua").oldfiles() end, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fc", function() require("fzf-lua").command_history() end, { desc = "Command history" })
