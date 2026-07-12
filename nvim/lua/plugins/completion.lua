-- ============================================================================
-- COMPLETION: blink.cmp (native vim.snippet, no LuaSnip)
-- ============================================================================

require("blink.cmp").setup({
    keymap = {
        preset = "none",
        -- Manual trigger (VS Code style)
        ["<C-Space>"] = { "show", "hide" },
        -- Accept
        ["<CR>"] = { "accept", "fallback" },
        -- Navigate suggestions: Ctrl-n / Ctrl-p
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        -- Also navigate with Ctrl-j / Ctrl-k
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        -- Tab: cycle suggestions, then snippet jump, then indent
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        -- Scroll docs
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    },
    appearance = { nerd_font_variant = "mono" },
    completion = {
        menu = {
            auto_show = function()
                return vim.bo.filetype ~= "markdown"
            end,
            border = "rounded",
            draw = {
                columns = {
                    { "kind_icon" },
                    { "label", "label_description", gap = 1 },
                    { "kind" },
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = { border = "rounded" },
        },
        ghost_text = { enabled = true },
    },
    signature = {
        enabled = true,
        window = { border = "rounded" },
    },
    sources = {
        default = { "lsp", "path", "buffer", "snippets" },
    },
    cmdline = {
        sources = function()
            local type = vim.fn.getcmdtype()
            if type == "/" or type == "?" then
                return { "buffer" }
            end
            if type == ":" then
                return { "cmdline" }
            end
            return {}
        end,
    },
    fuzzy = {
        implementation = "prefer_rust",
        prebuilt_binaries = { download = true },
    },
})
