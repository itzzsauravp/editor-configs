-- ============================================================================
-- PLUGIN DECLARATIONS (vim.pack)
-- ============================================================================

vim.pack.add({
    -- UI / Icons
    "https://github.com/echasnovski/mini.nvim",
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/ibhagwan/fzf-lua",

    -- Treesitter
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
    },

    -- LSP / Formatting
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/stevearc/conform.nvim",

    -- Completion
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("1.*"),
    },

    -- Rust LSP
    "https://github.com/mrcjkb/rustaceanvim",

    -- Git
    "https://github.com/lewis6991/gitsigns.nvim",

    -- Diagnostics
    "https://github.com/folke/trouble.nvim",

    -- QoL
    "https://github.com/folke/flash.nvim",
    "https://github.com/MagicDuck/grug-far.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/folke/which-key.nvim",

    -- Themes
    "https://github.com/catppuccin/nvim",
    "https://github.com/folke/tokyonight.nvim",
    "https://github.com/rebelot/kanagawa.nvim",
    "https://github.com/ellisonleao/gruvbox.nvim",
    "https://github.com/neanias/everforest-nvim",
    "https://github.com/rose-pine/neovim",
    "https://github.com/shaunsingh/nord.nvim",
    "https://github.com/navarasu/onedark.nvim",
    "https://github.com/nyoom-engineering/oxocarbon.nvim",
    "https://github.com/EdenEast/nightfox.nvim",
    "https://github.com/projekt0n/github-nvim-theme",
})
