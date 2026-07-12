-- ============================================================================
-- FORMATTING: conform.nvim (format on save + manual format key)
-- ============================================================================

require("conform").setup({
    formatters_by_ft = {
        -- Primary languages
        lua = { "stylua" },
        rust = { "rustfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        zig = { "zigfmt" },
        odin = { "odinfmt" },

        -- Web
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },

        -- Other
        python = { "black" },
        go = { "gofumpt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        toml = { "taplo" },
    },

    -- Format on save: runs automatically for all configured filetypes
    format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
    },

    -- Notify when no formatter is available
    notify_on_error = true,
})
