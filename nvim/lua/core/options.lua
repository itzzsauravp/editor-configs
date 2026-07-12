-- ============================================================================
-- CORE OPTIONS
-- ============================================================================

vim.opt.termguicolors = true
-- NOTE: Colorscheme is managed by core/theme.lua (persistent theme manager)

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- UI
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.synmaxcol = 300
vim.opt.fillchars = { eob = " " }

-- Undo / Swap / Backup
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = undodir

-- Performance
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 50
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Behavior
vim.opt.autoread = true
vim.opt.autowrite = false
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "inclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable = true

-- Cursor shapes by mode
vim.opt.guicursor = {
    "n-v-c:block",           -- Block in Normal, Visual, Command
    "i-ci-ve:ver25",         -- Vertical bar in Insert
    "r-cr:hor20",            -- Horizontal bar in Replace
    "o:hor50",               -- Horizontal bar in Operator-pending
    "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
}

-- Folding (treesitter-based)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Completion / Diff
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.diffopt:append("linematch:60")
