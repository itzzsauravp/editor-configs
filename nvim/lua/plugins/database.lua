-- =============================================================================
-- DATABASE CLIENT (vim-dadbod + dadbod-ui)
-- =============================================================================
--
-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                        DATABASE CHEATSHEET                             ║
-- ╠══════════════════════════════════════════════════════════════════════════╣
-- ║                                                                        ║
-- ║  OPENING THE DATABASE UI:                                              ║
-- ║    <leader>db     Toggle the DB UI panel (left sidebar + query editor)  ║
-- ║    <leader>da     Add a new database connection                         ║
-- ║    <leader>df     Find/search saved database connections                ║
-- ║                                                                        ║
-- ║  INSIDE THE DB UI SIDEBAR (left panel):                                ║
-- ║    Enter          Expand/collapse a connection or table                  ║
-- ║    o              Open table in query buffer (shows data)                ║
-- ║    R              Refresh the sidebar                                    ║
-- ║    d              Delete a saved connection                              ║
-- ║    r              Rename a saved connection                              ║
-- ║    S              Toggle showing table schema                            ║
-- ║                                                                        ║
-- ║  WRITING & EXECUTING QUERIES:                                          ║
-- ║    <leader>de     Execute the query under cursor (Normal mode)           ║
-- ║    <leader>de     Execute selected query (Visual mode — select lines)    ║
-- ║    <leader>dw     Save current query to a file                           ║
-- ║                                                                        ║
-- ║  HOW TO CONNECT TO DATABASES:                                          ║
-- ║                                                                        ║
-- ║    1. Press <leader>db to open the UI                                    ║
-- ║    2. Press <leader>da to add a connection                               ║
-- ║    3. Enter a connection URL:                                            ║
-- ║                                                                        ║
-- ║       PostgreSQL:                                                       ║
-- ║         postgres://username:password@localhost:5432/database_name        ║
-- ║                                                                        ║
-- ║       MySQL:                                                            ║
-- ║         mysql://username:password@localhost:3306/database_name           ║
-- ║                                                                        ║
-- ║       SQLite:                                                           ║
-- ║         sqlite:///absolute/path/to/database.db                          ║
-- ║                                                                        ║
-- ║       SQL Server (MSSQL):                                               ║
-- ║         sqlserver://user:pass@localhost:1433?database=mydb               ║
-- ║                                                                        ║
-- ║    4. Give it a friendly name (e.g. "dev_postgres")                      ║
-- ║    5. Press Enter — you're connected!                                    ║
-- ║                                                                        ║
-- ║  TIPS:                                                                  ║
-- ║    • Connections are saved in: ~/.local/share/db_ui/                     ║
-- ║    • Write .sql files in any project — dadbod auto-detects them          ║
-- ║    • Results appear in a formatted table below the query buffer          ║
-- ║    • Use <leader>de on a SELECT to see results instantly                 ║
-- ║    • You can have multiple connections open simultaneously               ║
-- ║                                                                        ║
-- ╚══════════════════════════════════════════════════════════════════════════╝
--
-- PRE-CONFIGURED CONNECTIONS:
--   If you want to define connections that are always available, set the
--   environment variable before opening Neovim:
--
--     export DBUI_URL="postgres://sauravp:root@localhost:5432/pbmis_lumbini"
--
--   Or add connections via the UI (<leader>da) — they persist across sessions.
-- =============================================================================

return {
  -- =========================================================================
  -- vim-dadbod: The database engine (runs queries, connects to databases)
  -- =========================================================================
  {
    "tpope/vim-dadbod",
    cmd = "DB",
  },

  -- =========================================================================
  -- vim-dadbod-ui: Beautiful UI wrapper (connection manager, query editor)
  -- =========================================================================
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- =====================================================================
      -- DADBOD-UI SETTINGS
      -- =====================================================================
      -- Use NerdFont icons in the sidebar
      vim.g.db_ui_use_nerd_fonts = 1

      -- Show table help text in the sidebar (column names, types)
      vim.g.db_ui_show_help = 0

      -- Auto-execute when selecting a table from sidebar (shows data instantly)
      vim.g.db_ui_auto_execute_table_helpers = 1

      -- Save queries here (per-project if inside a git repo)
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"

      -- Notification settings
      vim.g.db_ui_use_nvim_notify = 1

      -- Default page size for table previews
      vim.g.db_ui_default_query = "SELECT * FROM {table} LIMIT 100;"

      -- =====================================================================
      -- PRE-CONFIGURED CONNECTIONS (Removed)
      -- Connections are now managed entirely through the UI (<leader>da)
      -- so you can easily add, edit, and delete them without touching code.
      -- =====================================================================

      -- =====================================================================
      -- Auto-configure SQL completion & Results Window Layout
      -- =====================================================================
      
      -- 1. Enable SQL completion
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          require("cmp").setup.buffer({
            sources = {
              { name = "vim-dadbod-completion" },
              { name = "buffer" },
            },
          })
        end,
      })

      -- 2. Make query results show up at the bottom like a terminal
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dbout",
        callback = function()
          vim.cmd("wincmd J") -- Move the window to the very bottom
          vim.cmd("resize 15") -- Set height to 15 lines
          vim.opt_local.wrap = false -- Disable line wrapping for wide tables
        end,
      })
    end,

    keys = {
      { "<leader>db", "<Cmd>DBUIToggle<CR>", desc = "Toggle DB UI" },
      { "<leader>da", "<Cmd>DBUIAddConnection<CR>", desc = "Add DB Connection" },
      { "<leader>df", "<Cmd>DBUIFindBuffer<CR>", desc = "Find DB Buffer" },
      {
        "<leader>de",
        "<Plug>(DBUI_ExecuteQuery)",
        mode = { "n", "v" },
        desc = "Execute Query",
      },
      {
        "<leader>dw",
        "<Plug>(DBUI_SaveQuery)",
        desc = "Save Query",
      },
    },
  },
}
