-- ============================================================================
-- NEOVIM CONFIGURATION ENTRY POINT
-- Architecture: core/ for base settings, plugins/ for plugin configs
-- ============================================================================

-- Leader must be set before any <leader> mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core
require("core.options")

-- Plugins: declaration + setup
require("plugins.bootstrap")
require("plugins.treesitter")
require("plugins.ui")
require("plugins.completion")
require("plugins.lsp")
require("plugins.diagnostics")
require("plugins.conform")
require("plugins.git")
require("plugins.qol")

-- Core (after plugins, so statusline/autocmds can reference plugin state)
require("core.theme")
require("core.statusline")
require("core.autocmds")
require("core.keymaps")
