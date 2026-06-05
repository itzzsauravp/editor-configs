-- =============================================================================
-- TERMINAL & TUI CONFIGURATION (toggleterm.nvim)
-- =============================================================================
--
-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                          TERMINAL CHEATSHEET                           ║
-- ╠══════════════════════════════════════════════════════════════════════════╣
-- ║                                                                        ║
-- ║  OPENING TERMINALS:                                                    ║
-- ║    <C-\>          Toggle the default terminal (horizontal split)        ║
-- ║    <leader>tt     Toggle terminal (default horizontal)                  ║
-- ║    <leader>tf     Toggle floating terminal                              ║
-- ║    <leader>th     Toggle horizontal terminal                            ║
-- ║    <leader>tv     Toggle vertical terminal (40 cols wide)               ║
-- ║    <leader>t1-t4  Open numbered terminals (1 through 4)                 ║
-- ║                                                                        ║
-- ║  INSIDE A REGULAR TERMINAL:                                            ║
-- ║    jk             Exit terminal mode → Normal mode                      ║
-- ║    <C-h/j/k/l>    Navigate between windows (terminal ↔ editor)         ║
-- ║    <C-w>          Enter window command mode (then use H/J/K/L to move)  ║
-- ║                                                                        ║
-- ║  MOVING TERMINAL WINDOWS (from Normal mode inside terminal):           ║
-- ║    <C-w> Shift+L   Move terminal to vertical right split               ║
-- ║    <C-w> Shift+H   Move terminal to vertical left split                ║
-- ║    <C-w> Shift+J   Move terminal to horizontal bottom split            ║
-- ║    <C-w> Shift+K   Move terminal to horizontal top split               ║
-- ║                                                                        ║
-- ╠══════════════════════════════════════════════════════════════════════════╣
-- ║                                                                        ║
-- ║  TUI APPLICATIONS (float over your editor):                            ║
-- ║                                                                        ║
-- ║  LazyDocker (<leader>td):                                              ║
-- ║    • Manage Docker containers, images, volumes, networks                ║
-- ║    • Navigate with arrow keys or hjkl                                   ║
-- ║    • Press Enter to select, Esc to go back                              ║
-- ║    • Press <C-q> or <leader>td again to close                           ║
-- ║                                                                        ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
--
-- WHY jk INSTEAD OF <Esc> TO EXIT TERMINAL MODE?
--   TUI apps (like lazydocker) need <Esc> for their own navigation.
--   If we map <Esc> to exit terminal mode, you can never press Escape inside
--   those apps. Using jk (which matches your insert mode exit mapping) avoids
--   this conflict entirely. In regular terminals, just type jk quickly.
-- =============================================================================

-- Track which terminal buffers are TUI apps so we can apply different keymaps
local tui_buffers = {}

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 18
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.35
          end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          title_pos = "center",
        },
      })

      -- =====================================================================
      -- Keymaps for REGULAR terminals (not TUI apps)
      -- =====================================================================
      function _G.set_terminal_keymaps()
        local bufnr = vim.api.nvim_get_current_buf()

        -- Skip TUI buffers — they handle their own keys
        if tui_buffers[bufnr] then
          return
        end

        local opts = { buffer = bufnr, silent = true }

        -- Exit terminal mode with jk (leaves <Esc> free for TUI apps)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)

        -- Window navigation directly from terminal mode
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end

      vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

      -- =====================================================================
      -- TUI Terminal Factory
      -- Creates a persistent, full-screen floating terminal for TUI apps.
      -- <Esc> works inside the app. <C-q> closes the float.
      -- =====================================================================
      local Terminal = require("toggleterm.terminal").Terminal

      local function create_tui_terminal(cmd, title)
        return Terminal:new({
          cmd = cmd,
          hidden = true,
          direction = "float",
          close_on_exit = true,
          float_opts = {
            border = "curved",
            width = function()
              return math.floor(vim.o.columns * 0.9)
            end,
            height = function()
              return math.floor(vim.o.lines * 0.85)
            end,
            title = " " .. title .. " ",
            title_pos = "center",
          },
          on_open = function(term)
            vim.cmd("startinsert!")
            -- Mark this buffer as a TUI so regular keymaps are skipped
            tui_buffers[term.bufnr] = true
            -- <C-q> to close the TUI float (doesn't conflict with any TUI app)
            vim.api.nvim_buf_set_keymap(
              term.bufnr,
              "t",
              "<C-q>",
              "<Cmd>close<CR>",
              { noremap = true, silent = true, desc = "Close " .. title }
            )
          end,
          on_close = function(term)
            tui_buffers[term.bufnr] = nil
          end,
        })
      end

      -- Persistent TUI instances (created once, toggled thereafter)
      _G.lazydocker_term = _G.lazydocker_term or create_tui_terminal("lazydocker", "🐳 LazyDocker")
    end,

    keys = {
      -- Regular terminals
      { "<leader>tt", "<Cmd>ToggleTerm<CR>", desc = "Toggle Terminal (Default)" },
      { "<leader>tf", "<Cmd>ToggleTerm direction=float<CR>", desc = "Toggle Floating Terminal" },
      { "<leader>th", "<Cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle Horizontal Terminal" },
      { "<leader>tv", "<Cmd>ToggleTerm direction=vertical size=40<CR>", desc = "Toggle Vertical Terminal" },
      { "<leader>t1", "<Cmd>1ToggleTerm<CR>", desc = "Terminal 1" },
      { "<leader>t2", "<Cmd>2ToggleTerm<CR>", desc = "Terminal 2" },
      { "<leader>t3", "<Cmd>3ToggleTerm<CR>", desc = "Terminal 3" },
      { "<leader>t4", "<Cmd>4ToggleTerm<CR>", desc = "Terminal 4" },

      -- TUI: LazyDocker
      {
        "<leader>td",
        function()
          _G.lazydocker_term:toggle()
        end,
        desc = "LazyDocker (Float)",
      },
    },
  },
}
