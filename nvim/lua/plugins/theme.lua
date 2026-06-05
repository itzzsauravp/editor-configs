return {
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "deep",
      colors = {
        -- Defining a custom palette to use below
        bg0 = "#181818", -- Main background
        bg1 = "#242424", -- Slightly lighter for floats/popups
        bg2 = "#2e2e2e", -- Even lighter for borders/selection
        fg = "#cccccc", -- A clean, soft white for text
        grey = "#484848", -- Visible border color
      },
      highlights = {
        -- Main Editor
        ["Normal"] = { bg = "$bg0", fg = "$fg" },
        ["NormalNC"] = { bg = "$bg0" }, -- Non-current windows

        -- Floating Windows (LSP hover, diagnostics)
        ["NormalFloat"] = { bg = "$bg1" },
        ["FloatBorder"] = { bg = "$bg1", fg = "$grey" }, -- Borders are now visible

        -- Popup Menus (Completion, Which-Key)
        ["Pmenu"] = { bg = "$bg1", fg = "$fg" },
        ["PmenuSel"] = { bg = "$bg2", fg = "#ffffff" }, -- Highlighted item
        ["PmenuSbar"] = { bg = "$bg1" },
        ["PmenuThumb"] = { bg = "$grey" },

        -- Line Numbers & Gutter
        ["LineNr"] = { bg = "$bg0", fg = "#555555" },
        ["CursorLineNr"] = { bg = "$bg0", fg = "#888888" },
        ["SignColumn"] = { bg = "$bg0" },

        -- Telescope (If you use it, this matches the vibe)
        ["TelescopeNormal"] = { bg = "$bg1" },
        ["TelescopeBorder"] = { bg = "$bg1", fg = "$grey" },
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
