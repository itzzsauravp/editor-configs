return {
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    keys = {
      {
        "<leader>sr",
        function()
          require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace (Current File)",
      },
      {
        "<leader>sx",
        function()
          require("grug-far").open({})
        end,
        mode = { "n", "v" },
        desc = "Search and Replace (Project)",
      },
    },
  },
  {
    "mg979/vim-visual-multi",
    init = function()
      -- Customizing keybinds to feel more natural
      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>", -- Select word (like Ctrl+D in VS Code)
        ["Find Next"] = "<C-n>",
        ["Select All"] = "<C-a>", -- Select all occurrences
      }
    end,
  },
}
