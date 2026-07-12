-- ============================================================================
-- LSP, LINTING, CONFIG
-- ============================================================================
require("mason").setup({})

vim.lsp.config["*"] = {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
}

-- Rounded borders for all LSP floating windows
do
    local orig = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        opts.max_width = opts.max_width or 80
        opts.max_height = opts.max_height or 20
        return orig(contents, syntax, opts, ...)
    end
end

-- LSP servers
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
        },
    },
})
vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})
vim.lsp.config("zls", {})
vim.lsp.config("ols", {})
vim.lsp.config("jsonls", {})
vim.lsp.config("yamlls", {})
vim.lsp.config("html", {})
vim.lsp.config("cssls", {})

-- Rustaceanvim: managed by rustup, NOT Mason
-- Optimized: limit check targets and proc-macro expansion
vim.g.rustaceanvim = {
    server = {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        default_settings = {
            ["rust-analyzer"] = {
                check = {
                    command = "clippy",
                    allTargets = false, -- Don't check all targets on startup
                },
                procMacro = {
                    enable = true,
                    attributes = { enable = true },
                },
                cargo = {
                    loadOutDirsFromCheck = true,
                },
                diagnostics = {
                    disabled = { "unresolved-proc-macro" },
                },
            },
        },
    },
}

-- Enable all LSP servers
vim.lsp.enable({
    "lua_ls", "pyright", "bashls", "ts_ls", "gopls", "clangd",
    "zls", "ols", "jsonls", "yamlls", "html", "cssls",
})

-- LSP keymaps (attached per-buffer on LspAttach)
local lsp_group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then return end
        local bufnr = ev.buf

        vim.keymap.set("n", "gd", function() require("fzf-lua").lsp_definitions({ jump_to_single_result = true }) end, { buffer = bufnr, desc = "Go to definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
        vim.keymap.set("n", "gi", function() require("fzf-lua").lsp_implementations() end, { buffer = bufnr, desc = "Go to implementation" })
        vim.keymap.set("n", "gr", function() require("fzf-lua").lsp_references() end, { buffer = bufnr, desc = "Go to references" })
        vim.keymap.set("n", "gy", function() require("fzf-lua").lsp_typedefs() end, { buffer = bufnr, desc = "Go to type definition" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
        vim.keymap.set("n", "<leader>fs", function() require("fzf-lua").lsp_document_symbols() end, { buffer = bufnr, desc = "Document symbols" })
        vim.keymap.set("n", "<leader>fS", function() require("fzf-lua").lsp_workspace_symbols() end, { buffer = bufnr, desc = "Workspace symbols" })

        -- Document highlight on cursor hold (references under cursor)
        if client:supports_method("textDocument/documentHighlight") then
            local hl_group = vim.api.nvim_create_augroup("LspDocHighlight_" .. bufnr, { clear = true })
            vim.api.nvim_create_autocmd("CursorHold", {
                group = hl_group,
                buffer = bufnr,
                callback = function() vim.lsp.buf.document_highlight() end,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                group = hl_group,
                buffer = bufnr,
                callback = function() vim.lsp.buf.clear_references() end,
            })
        end
    end,
})
