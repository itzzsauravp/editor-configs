-- ============================================================================
-- THEME: Persistent colorscheme manager with :Theme command + fzf picker
-- ============================================================================

local M = {}

local theme_file = vim.fn.stdpath("config") .. "/.theme_persistent"

-- All available themes with their setup functions (some need setup() before use)
local theme_registry = {
    -- Catppuccin variants
    ["catppuccin"]          = { mod = "catppuccin", scheme = "catppuccin" },
    ["catppuccin-latte"]    = { mod = "catppuccin", scheme = "catppuccin-latte" },
    ["catppuccin-frappe"]   = { mod = "catppuccin", scheme = "catppuccin-frappe" },
    ["catppuccin-macchiato"]= { mod = "catppuccin", scheme = "catppuccin-macchiato" },
    ["catppuccin-mocha"]    = { mod = "catppuccin", scheme = "catppuccin-mocha" },
    -- Tokyo Night variants
    ["tokyonight"]          = { mod = "tokyonight", scheme = "tokyonight" },
    ["tokyonight-night"]    = { mod = "tokyonight", scheme = "tokyonight-night" },
    ["tokyonight-storm"]    = { mod = "tokyonight", scheme = "tokyonight-storm" },
    ["tokyonight-day"]      = { mod = "tokyonight", scheme = "tokyonight-day" },
    ["tokyonight-moon"]     = { mod = "tokyonight", scheme = "tokyonight-moon" },
    -- Kanagawa variants
    ["kanagawa"]            = { mod = "kanagawa", scheme = "kanagawa" },
    ["kanagawa-wave"]       = { mod = "kanagawa", scheme = "kanagawa-wave" },
    ["kanagawa-dragon"]     = { mod = "kanagawa", scheme = "kanagawa-dragon" },
    ["kanagawa-lotus"]      = { mod = "kanagawa", scheme = "kanagawa-lotus" },
    -- Gruvbox
    ["gruvbox"]             = { mod = "gruvbox", scheme = "gruvbox" },
    -- Everforest
    ["everforest"]          = { mod = "everforest", scheme = "everforest" },
    -- Rose Pine variants
    ["rose-pine"]           = { mod = "rose-pine", scheme = "rose-pine" },
    ["rose-pine-main"]      = { mod = "rose-pine", scheme = "rose-pine-main" },
    ["rose-pine-moon"]      = { mod = "rose-pine", scheme = "rose-pine-moon" },
    ["rose-pine-dawn"]      = { mod = "rose-pine", scheme = "rose-pine-dawn" },
    -- Nord
    ["nord"]                = { scheme = "nord" },
    -- OneDark
    ["onedark"]             = { mod = "onedark", scheme = "onedark" },
    -- Oxocarbon
    ["oxocarbon"]           = { scheme = "oxocarbon" },
    -- Nightfox variants
    ["nightfox"]            = { mod = "nightfox", scheme = "nightfox" },
    ["dawnfox"]             = { mod = "nightfox", scheme = "dawnfox" },
    ["dayfox"]              = { mod = "nightfox", scheme = "dayfox" },
    ["duskfox"]             = { mod = "nightfox", scheme = "duskfox" },
    ["nordfox"]             = { mod = "nightfox", scheme = "nordfox" },
    ["terafox"]             = { mod = "nightfox", scheme = "terafox" },
    ["carbonfox"]           = { mod = "nightfox", scheme = "carbonfox" },
    -- GitHub variants
    ["github_dark"]             = { mod = "github-theme", scheme = "github_dark" },
    ["github_dark_default"]     = { mod = "github-theme", scheme = "github_dark_default" },
    ["github_dark_dimmed"]      = { mod = "github-theme", scheme = "github_dark_dimmed" },
    ["github_light"]            = { mod = "github-theme", scheme = "github_light" },
    ["github_light_default"]    = { mod = "github-theme", scheme = "github_light_default" },
    -- Built-in fallbacks
    ["habamax"]             = { scheme = "habamax" },
    ["retrobox"]            = { scheme = "retrobox" },
    ["wildcharm"]           = { scheme = "wildcharm" },
}

-- Apply transparent background after switching themes
local function apply_transparency()
    local groups = {
        "Normal", "NormalNC", "EndOfBuffer", "NormalFloat", "FloatBorder",
        "SignColumn", "StatusLine", "StatusLineNC", "TabLine", "TabLineFill",
        "TabLineSel", "ColorColumn",
    }
    for _, g in ipairs(groups) do
        vim.api.nvim_set_hl(0, g, { bg = "none" })
    end
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

-- Save theme name to disk
local function save_theme(name)
    local f = io.open(theme_file, "w")
    if f then
        f:write(name)
        f:close()
    end
end

-- Load saved theme name from disk
local function load_saved_theme()
    local f = io.open(theme_file, "r")
    if f then
        local name = f:read("*l")
        f:close()
        return name
    end
    return nil
end

-- Apply a theme by name
function M.set_theme(name)
    local entry = theme_registry[name]
    if not entry then
        vim.notify("Unknown theme: " .. name, vim.log.levels.WARN)
        return false
    end

    -- Call setup() if needed (some themes require it before colorscheme)
    if entry.mod then
        local ok, mod = pcall(require, entry.mod)
        if ok and type(mod.setup) == "function" then
            mod.setup({})
        end
    end

    local ok, err = pcall(vim.cmd.colorscheme, entry.scheme)
    if not ok then
        vim.notify("Failed to load theme '" .. name .. "': " .. tostring(err), vim.log.levels.ERROR)
        return false
    end

    apply_transparency()
    save_theme(name)
    return true
end

-- Get sorted list of available theme names
function M.get_theme_names()
    local names = {}
    for name in pairs(theme_registry) do
        table.insert(names, name)
    end
    table.sort(names)
    return names
end

-- User command :Theme <name> with tab completion
vim.api.nvim_create_user_command("Theme", function(opts)
    M.set_theme(opts.args)
end, {
    nargs = 1,
    complete = function(arglead)
        local names = M.get_theme_names()
        if arglead == "" then
            return names
        end
        return vim.tbl_filter(function(name)
            return name:find(arglead, 1, true) == 1
        end, names)
    end,
    desc = "Switch and persist colorscheme",
})

-- FZF theme picker with live preview
vim.keymap.set("n", "<leader>th", function()
    local original = vim.g.colors_name or "habamax"
    local names = M.get_theme_names()

    require("fzf-lua").fzf_exec(names, {
        prompt = "Theme> ",
        preview = false,
        actions = {
            ["default"] = function(selected)
                if selected and selected[1] then
                    M.set_theme(selected[1])
                end
            end,
        },
        fzf_opts = {
            ["--preview-window"] = "hidden",
        },
        -- Live preview on cursor move
        fn_selected = function(selected)
            if selected and selected[1] then
                pcall(vim.cmd.colorscheme, selected[1])
                apply_transparency()
            end
        end,
    })
end, { desc = "Theme picker" })

-- Load saved theme on startup (or fallback to habamax)
local saved = load_saved_theme()
if saved and theme_registry[saved] then
    M.set_theme(saved)
else
    M.set_theme("habamax")
end

return M
