return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = true, -- Set to true if you want errors while typing (can be noisy)
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          focusable = true, -- This allows you to "enter" the window
        },
      },
    },
  },
}
