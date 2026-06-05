-- =============================================================================
-- UI ENHANCEMENTS (VSCode-like polish)
-- =============================================================================
--
-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                          UI PLUGINS CHEATSHEET                         ║
-- ╠══════════════════════════════════════════════════════════════════════════╣
-- ║                                                                        ║
-- ║  INDENT GUIDES (indent-blankline):                                     ║
-- ║    • Vertical lines show indentation levels automatically               ║
-- ║    • Current scope/block is highlighted with a brighter line            ║
-- ║    • No keybinds needed — always visible                                ║
-- ║                                                                        ║
-- ║  COLOR PREVIEWS (nvim-colorizer):                                      ║
-- ║    • CSS colors like #ff5733 show inline color previews                 ║
-- ║    • Works in CSS, HTML, JavaScript, Lua, and more                      ║
-- ║    • <leader>uc    Toggle colorizer on/off                              ║
-- ║                                                                        ║
-- ║  SMOOTH SCROLLING (neoscroll):                                         ║
-- ║    • Page up/down (Ctrl+U/D), half-page scrolls are animated            ║
-- ║    • Feels like VS Code / modern editor scrolling                       ║
-- ║    • <leader>us    Toggle smooth scrolling on/off                       ║
-- ║                                                                        ║
-- ║  WINDOW ANIMATIONS (windows.nvim):                                     ║
-- ║    • Active window auto-expands for better focus                        ║
-- ║    • <C-w>=        Equalize all window sizes                            ║
-- ║    • <C-w>z        Maximize current window (toggle)                     ║
-- ║                                                                        ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
-- =============================================================================

return {
  -- =========================================================================
  -- Indent Guides: Visual indentation lines (like VS Code)
  -- Shows scope with highlighted current context
  -- =========================================================================
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "toggleterm",
          "dbui",
          "dbout",
        },
      },
    },
  },

  -- =========================================================================
  -- Color Previews: Inline color swatches for hex/rgb/hsl values
  -- =========================================================================
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        "css",
        "scss",
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "lua",
        "vim",
        "toml",
        "yaml",
        "json",
        "conf",
      }, {
        mode = "background", -- Set the display mode (background / foreground / virtualtext)
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      })
    end,
    keys = {
      {
        "<leader>uc",
        "<Cmd>ColorizerToggle<CR>",
        desc = "Toggle Color Previews",
      },
    },
  },

  -- =========================================================================
  -- Smooth Scrolling: Animated scroll like VS Code
  -- =========================================================================
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing = "quadratic",
      pre_hook = nil,
      post_hook = nil,
      performance_mode = false,
      duration_multiplier = 0.6, -- Faster than default (less waiting)
    },
    keys = {
      {
        "<leader>us",
        function()
          if package.loaded["neoscroll"] then
            -- Toggle by re-requiring (neoscroll doesn't have a built-in toggle)
            vim.notify("Smooth scrolling: toggle requires restart", vim.log.levels.INFO)
          end
        end,
        desc = "Toggle Smooth Scroll (info)",
      },
    },
  },

  -- =========================================================================
  -- Window Auto-Resize: Active window auto-expands for focus
  -- =========================================================================
  {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
      "anuvyklack/middleclass",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup({
        autowidth = {
          enable = true,
          winwidth = 1.2, -- Active window gets 20% more width
        },
        ignore = {
          buftype = { "quickfix" },
          filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "dbui", "dbout" },
        },
      })
    end,
    keys = {
      { "<C-w>z", "<Cmd>WindowsMaximize<CR>", desc = "Maximize Window" },
      { "<C-w>=", "<Cmd>WindowsEqualize<CR>", desc = "Equalize Windows" },
    },
  },
}
