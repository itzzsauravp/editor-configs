-- ============================================================================
-- MODE-COLORED STATUSLINE WITH SYSTEM TIME
-- ============================================================================

-- WSL detection (for Windows system time)
local is_wsl = false
do
	local f = io.open("/proc/version", "r")
	if f then
		local content = f:read("*a")
		f:close()
		if content:lower():find("microsoft") then
			is_wsl = true
		end
	end
end

-- Cached system time (updated async every 30s)
local cached_time = os.date("%H:%M")

local function update_time()
	if is_wsl then
		vim.fn.jobstart({ "powershell.exe", "-NoProfile", "-Command", 'Get-Date -Format "HH:mm"' }, {
			stdout_buffered = true,
			on_stdout = function(_, data)
				if data and data[1] and data[1] ~= "" then
					cached_time = vim.fn.trim(data[1])
				end
			end,
		})
	else
		cached_time = os.date("%H:%M")
	end
end

local timer = vim.uv.new_timer()
timer:start(0, 30000, vim.schedule_wrap(update_time))

-- Git branch (cached, refreshed every 5s)
local cached_branch = ""
local last_branch_check = 0

local function git_branch()
	local now = vim.uv.now()
	if now - last_branch_check > 5000 then
		cached_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\\n'")
		last_branch_check = now
	end
	if cached_branch ~= "" then
		return " \u{e725} " .. cached_branch .. " "
	end
	return ""
end

-- File type with Nerd Font icon
local ft_icons = {
	lua = "\u{e620} ", python = "\u{e73c} ", javascript = "\u{e74e} ",
	typescript = "\u{e628} ", javascriptreact = "\u{e7ba} ", typescriptreact = "\u{e7ba} ",
	html = "\u{e736} ", css = "\u{e749} ", scss = "\u{e749} ", json = "\u{e60b} ",
	markdown = "\u{e73e} ", vim = "\u{e62b} ", sh = "\u{f489} ", bash = "\u{f489} ",
	zsh = "\u{f489} ", rust = "\u{e7a8} ", go = "\u{e724} ", c = "\u{e61e} ",
	cpp = "\u{e61d} ", java = "\u{e738} ", yaml = "\u{f481} ", toml = "\u{e615} ",
	dockerfile = "\u{f308} ", gitcommit = "\u{f418} ", vue = "\u{fd42} ",
	svelte = "\u{e697} ", astro = "\u{e628} ",
}

local function file_type()
	local ft = vim.bo.filetype
	if ft == "" then
		return ""
	end
	return (ft_icons[ft] or "\u{f15b} ") .. ft
end

-- Mode config: label + muted colors
local mode_config = {
	n     = { label = "NORMAL",   fg = "#1a1a2e", bg = "#7aa2f7" },
	i     = { label = "INSERT",   fg = "#1a1a2e", bg = "#9ece6a" },
	v     = { label = "VISUAL",   fg = "#1a1a2e", bg = "#bb9af7" },
	V     = { label = "V-LINE",   fg = "#1a1a2e", bg = "#bb9af7" },
	["\22"] = { label = "V-BLOCK", fg = "#1a1a2e", bg = "#bb9af7" },
	c     = { label = "COMMAND",  fg = "#1a1a2e", bg = "#e0af68" },
	s     = { label = "SELECT",   fg = "#1a1a2e", bg = "#ff9e64" },
	S     = { label = "S-LINE",   fg = "#1a1a2e", bg = "#ff9e64" },
	["\19"] = { label = "S-BLOCK", fg = "#1a1a2e", bg = "#ff9e64" },
	R     = { label = "REPLACE",  fg = "#1a1a2e", bg = "#f7768e" },
	r     = { label = "REPLACE",  fg = "#1a1a2e", bg = "#f7768e" },
	["!"] = { label = "SHELL",    fg = "#1a1a2e", bg = "#73daca" },
	t     = { label = "TERMINAL", fg = "#1a1a2e", bg = "#73daca" },
}

local function update_mode_hl()
	local mode = vim.fn.mode()
	local cfg = mode_config[mode] or { fg = "#1a1a2e", bg = "#a9b1d6" }
	vim.api.nvim_set_hl(0, "StatusMode", { fg = cfg.fg, bg = cfg.bg, bold = true })
	vim.api.nvim_set_hl(0, "StatusModeSep", { fg = cfg.bg, bg = "none" })
end

-- Global functions for statusline %{} expressions
_G._stl_mode = function()
	local mode = vim.fn.mode()
	local cfg = mode_config[mode] or { label = mode }
	return " " .. cfg.label .. " "
end
_G._stl_branch = git_branch
_G._stl_ft = file_type
_G._stl_time = function()
	return cached_time
end

-- Statusline strings
local function active_statusline()
	return table.concat({
		"%#StatusMode#",
		"%{v:lua._stl_mode()}",
		"%#StatusModeSep#\u{e0b0}%#StatusLine#",
		" %f %h%m%r",
		"%{v:lua._stl_branch()}",
		" \u{e0b1} %{v:lua._stl_ft()}",
		"%=",
		" %l:%c  %P ",
		"\u{e0b1} \u{f017} %{v:lua._stl_time()} ",
	})
end

local function inactive_statusline()
	return "  %f %h%m%r %= %l:%c  %P "
end

-- Autocmds
local stl_group = vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = stl_group,
	callback = function()
		update_mode_hl()
		vim.opt_local.statusline = active_statusline()
	end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
	group = stl_group,
	callback = function()
		update_mode_hl()
		vim.cmd("redrawstatus")
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = stl_group,
	callback = function()
		vim.opt_local.statusline = inactive_statusline()
	end,
})

-- Set initial mode highlight
update_mode_hl()
