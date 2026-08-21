-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- ============================================================
-- Vim-style ALT navigation (added first)
-- ============================================================
o.bind("ALT + H", "Focus left window (vim)",  hl.dsp.focus({ direction = "l" }))
o.bind("ALT + J", "Focus below window (vim)", hl.dsp.focus({ direction = "d" }))
o.bind("ALT + K", "Focus above window (vim)", hl.dsp.focus({ direction = "u" }))
o.bind("ALT + L", "Focus right window (vim)", hl.dsp.focus({ direction = "r" }))

o.bind("ALT + SHIFT + H", "Move window left (vim)",  hl.dsp.window.move({ direction = "l" }))
o.bind("ALT + SHIFT + J", "Move window down (vim)",  hl.dsp.window.move({ direction = "d" }))
o.bind("ALT + SHIFT + K", "Move window up (vim)",    hl.dsp.window.move({ direction = "u" }))
o.bind("ALT + SHIFT + L", "Move window right (vim)", hl.dsp.window.move({ direction = "r" }))

o.bind("ALT + SHIFT + W", "Move workspace to up monitor (vim)",    hl.dsp.workspace.move({ monitor = "u" }))
o.bind("ALT + SHIFT + A", "Move workspace to left monitor (vim)",  hl.dsp.workspace.move({ monitor = "l" }))
o.bind("ALT + SHIFT + S", "Move workspace to down monitor (vim)",  hl.dsp.workspace.move({ monitor = "d" }))
o.bind("ALT + SHIFT + D", "Move workspace to right monitor (vim)", hl.dsp.workspace.move({ monitor = "r" }))

-- ============================================================
-- ALT-as-SUPER conversion: every default SUPER-based bind gets
-- an ALT-based twin. Generated + collision-checked. Do not hand
-- edit the generated block below unless you know what you're doing;
-- your own custom binds can go after it.
-- ============================================================

hl.unbind("SUPER + W")
o.bind("ALT + Q", "Close window", hl.dsp.window.close())

-- kept on SUPER (ALT slot taken): SUPER + J -> "Toggle window split"
hl.unbind("SUPER + P")
o.bind("ALT + P", "Pseudo window", hl.dsp.window.pseudo())

hl.unbind("SUPER + T")
o.bind("ALT + T", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))

hl.unbind("SUPER + F")
o.bind("ALT + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

hl.unbind("SUPER + CTRL + F")
o.bind("CTRL + ALT + F", "Tiled full screen", "omarchy-hyprland-window-tiled-fullscreen-toggle")

hl.unbind("SUPER + ALT + F")
o.bind("ALT + SUPER + F", "Full width", hl.dsp.window.fullscreen({ mode = "maximized" }))

hl.unbind("SUPER + O")
o.bind("ALT + O", "Pop window out (float & pin)", "omarchy-hyprland-window-pop")

hl.unbind("SUPER + ALT + Home")
o.bind("ALT + SUPER + Home", "Save window width", "omarchy-hyprland-window-width save")

hl.unbind("SUPER + Home")
o.bind("ALT + Home", "Restore window width", "omarchy-hyprland-window-width restore")

-- kept on SUPER (ALT slot taken): SUPER + L -> "Toggle workspace layout"
hl.unbind("SUPER + LEFT")
o.bind("ALT + LEFT", "Focus on left window", hl.dsp.focus({ direction = "l" }))

hl.unbind("SUPER + RIGHT")
o.bind("ALT + RIGHT", "Focus on right window", hl.dsp.focus({ direction = "r" }))

hl.unbind("SUPER + UP")
o.bind("ALT + UP", "Focus on above window", hl.dsp.focus({ direction = "u" }))

hl.unbind("SUPER + DOWN")
o.bind("ALT + DOWN", "Focus on below window", hl.dsp.focus({ direction = "d" }))

hl.unbind("SUPER + code:10")
o.bind("ALT + code:10", "Switch to workspace 1", hl.dsp.focus({ workspace = "1" }))

hl.unbind("SUPER + SHIFT + code:10")
o.bind("ALT + SHIFT + code:10", "Move window to workspace 1", hl.dsp.window.move({ workspace = "1" }))

hl.unbind("SUPER + SHIFT + ALT + code:10")
o.bind("ALT + SHIFT + SUPER + code:10", "Move window silently to workspace 1", hl.dsp.window.move({ workspace = "1", follow = false }))

hl.unbind("SUPER + code:11")
o.bind("ALT + code:11", "Switch to workspace 2", hl.dsp.focus({ workspace = "2" }))

hl.unbind("SUPER + SHIFT + code:11")
o.bind("ALT + SHIFT + code:11", "Move window to workspace 2", hl.dsp.window.move({ workspace = "2" }))

hl.unbind("SUPER + SHIFT + ALT + code:11")
o.bind("ALT + SHIFT + SUPER + code:11", "Move window silently to workspace 2", hl.dsp.window.move({ workspace = "2", follow = false }))

hl.unbind("SUPER + code:12")
o.bind("ALT + code:12", "Switch to workspace 3", hl.dsp.focus({ workspace = "3" }))

hl.unbind("SUPER + SHIFT + code:12")
o.bind("ALT + SHIFT + code:12", "Move window to workspace 3", hl.dsp.window.move({ workspace = "3" }))

hl.unbind("SUPER + SHIFT + ALT + code:12")
o.bind("ALT + SHIFT + SUPER + code:12", "Move window silently to workspace 3", hl.dsp.window.move({ workspace = "3", follow = false }))

hl.unbind("SUPER + code:13")
o.bind("ALT + code:13", "Switch to workspace 4", hl.dsp.focus({ workspace = "4" }))

hl.unbind("SUPER + SHIFT + code:13")
o.bind("ALT + SHIFT + code:13", "Move window to workspace 4", hl.dsp.window.move({ workspace = "4" }))

hl.unbind("SUPER + SHIFT + ALT + code:13")
o.bind("ALT + SHIFT + SUPER + code:13", "Move window silently to workspace 4", hl.dsp.window.move({ workspace = "4", follow = false }))

hl.unbind("SUPER + code:14")
o.bind("ALT + code:14", "Switch to workspace 5", hl.dsp.focus({ workspace = "5" }))

hl.unbind("SUPER + SHIFT + code:14")
o.bind("ALT + SHIFT + code:14", "Move window to workspace 5", hl.dsp.window.move({ workspace = "5" }))

hl.unbind("SUPER + SHIFT + ALT + code:14")
o.bind("ALT + SHIFT + SUPER + code:14", "Move window silently to workspace 5", hl.dsp.window.move({ workspace = "5", follow = false }))

hl.unbind("SUPER + code:15")
o.bind("ALT + code:15", "Switch to workspace 6", hl.dsp.focus({ workspace = "6" }))

hl.unbind("SUPER + SHIFT + code:15")
o.bind("ALT + SHIFT + code:15", "Move window to workspace 6", hl.dsp.window.move({ workspace = "6" }))

hl.unbind("SUPER + SHIFT + ALT + code:15")
o.bind("ALT + SHIFT + SUPER + code:15", "Move window silently to workspace 6", hl.dsp.window.move({ workspace = "6", follow = false }))

hl.unbind("SUPER + code:16")
o.bind("ALT + code:16", "Switch to workspace 7", hl.dsp.focus({ workspace = "7" }))

hl.unbind("SUPER + SHIFT + code:16")
o.bind("ALT + SHIFT + code:16", "Move window to workspace 7", hl.dsp.window.move({ workspace = "7" }))

hl.unbind("SUPER + SHIFT + ALT + code:16")
o.bind("ALT + SHIFT + SUPER + code:16", "Move window silently to workspace 7", hl.dsp.window.move({ workspace = "7", follow = false }))

hl.unbind("SUPER + code:17")
o.bind("ALT + code:17", "Switch to workspace 8", hl.dsp.focus({ workspace = "8" }))

hl.unbind("SUPER + SHIFT + code:17")
o.bind("ALT + SHIFT + code:17", "Move window to workspace 8", hl.dsp.window.move({ workspace = "8" }))

hl.unbind("SUPER + SHIFT + ALT + code:17")
o.bind("ALT + SHIFT + SUPER + code:17", "Move window silently to workspace 8", hl.dsp.window.move({ workspace = "8", follow = false }))

hl.unbind("SUPER + code:18")
o.bind("ALT + code:18", "Switch to workspace 9", hl.dsp.focus({ workspace = "9" }))

hl.unbind("SUPER + SHIFT + code:18")
o.bind("ALT + SHIFT + code:18", "Move window to workspace 9", hl.dsp.window.move({ workspace = "9" }))

hl.unbind("SUPER + SHIFT + ALT + code:18")
o.bind("ALT + SHIFT + SUPER + code:18", "Move window silently to workspace 9", hl.dsp.window.move({ workspace = "9", follow = false }))

hl.unbind("SUPER + code:19")
o.bind("ALT + code:19", "Switch to workspace 10", hl.dsp.focus({ workspace = "10" }))

hl.unbind("SUPER + SHIFT + code:19")
o.bind("ALT + SHIFT + code:19", "Move window to workspace 10", hl.dsp.window.move({ workspace = "10" }))

hl.unbind("SUPER + SHIFT + ALT + code:19")
o.bind("ALT + SHIFT + SUPER + code:19", "Move window silently to workspace 10", hl.dsp.window.move({ workspace = "10", follow = false }))

hl.unbind("SUPER + S")
o.bind("ALT + S", "Toggle scratchpad", hl.dsp.workspace.toggle_special("scratchpad"))

hl.unbind("SUPER + ALT + S")
o.bind("ALT + SUPER + S", "Move window to scratchpad", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

hl.unbind("SUPER + grave")
o.bind("ALT + grave", "Toggle scratchpad", hl.dsp.workspace.toggle_special("scratchpad"))

hl.unbind("SUPER + SHIFT + grave")
o.bind("ALT + SHIFT + grave", "Move window to scratchpad", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

-- kept on SUPER (ALT slot taken): SUPER + TAB -> "Next workspace"
-- kept on SUPER (ALT slot taken): SUPER + SHIFT + TAB -> "Previous workspace"
-- kept on SUPER (ALT slot taken): SUPER + CTRL + TAB -> "Former workspace"
hl.unbind("SUPER + SHIFT + ALT + LEFT")
o.bind("ALT + SHIFT + SUPER + LEFT", "Move workspace to left monitor", hl.dsp.workspace.move({ monitor = "l" }))

hl.unbind("SUPER + SHIFT + ALT + RIGHT")
o.bind("ALT + SHIFT + SUPER + RIGHT", "Move workspace to right monitor", hl.dsp.workspace.move({ monitor = "r" }))

hl.unbind("SUPER + SHIFT + ALT + UP")
o.bind("ALT + SHIFT + SUPER + UP", "Move workspace to up monitor", hl.dsp.workspace.move({ monitor = "u" }))

hl.unbind("SUPER + SHIFT + ALT + DOWN")
o.bind("ALT + SHIFT + SUPER + DOWN", "Move workspace to down monitor", hl.dsp.workspace.move({ monitor = "d" }))

hl.unbind("SUPER + SHIFT + LEFT")
o.bind("ALT + SHIFT + LEFT", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))

hl.unbind("SUPER + SHIFT + RIGHT")
o.bind("ALT + SHIFT + RIGHT", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))

hl.unbind("SUPER + SHIFT + UP")
o.bind("ALT + SHIFT + UP", "Swap window up", hl.dsp.window.swap({ direction = "u" }))

hl.unbind("SUPER + SHIFT + DOWN")
o.bind("ALT + SHIFT + DOWN", "Swap window down", hl.dsp.window.swap({ direction = "d" }))

hl.unbind("SUPER + code:20")
o.bind("ALT + code:20", "Expand window left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))

hl.unbind("SUPER + code:21")
o.bind("ALT + code:21", "Shrink window left", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))

hl.unbind("SUPER + SHIFT + code:20")
o.bind("ALT + SHIFT + code:20", "Shrink window up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))

hl.unbind("SUPER + SHIFT + code:21")
o.bind("ALT + SHIFT + code:21", "Expand window down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))

hl.unbind("SUPER + ALT + code:20")
o.bind("ALT + SUPER + code:20", "Expand window left a little", hl.dsp.window.resize({ x = -25, y = 0, relative = true }))

hl.unbind("SUPER + ALT + code:21")
o.bind("ALT + SUPER + code:21", "Shrink window left a little", hl.dsp.window.resize({ x = 25, y = 0, relative = true }))

hl.unbind("SUPER + SHIFT + ALT + code:20")
o.bind("ALT + SHIFT + SUPER + code:20", "Shrink window up a little", hl.dsp.window.resize({ x = 0, y = -25, relative = true }))

hl.unbind("SUPER + SHIFT + ALT + code:21")
o.bind("ALT + SHIFT + SUPER + code:21", "Expand window down a little", hl.dsp.window.resize({ x = 0, y = 25, relative = true }))

hl.unbind("SUPER + CTRL + code:20")
o.bind("CTRL + ALT + code:20", "Expand window left a lot", hl.dsp.window.resize({ x = -300, y = 0, relative = true }))

hl.unbind("SUPER + CTRL + code:21")
o.bind("CTRL + ALT + code:21", "Shrink window left a lot", hl.dsp.window.resize({ x = 300, y = 0, relative = true }))

hl.unbind("SUPER + CTRL + SHIFT + code:20")
o.bind("CTRL + ALT + SHIFT + code:20", "Shrink window up a lot", hl.dsp.window.resize({ x = 0, y = -300, relative = true }))

hl.unbind("SUPER + CTRL + SHIFT + code:21")
o.bind("CTRL + ALT + SHIFT + code:21", "Expand window down a lot", hl.dsp.window.resize({ x = 0, y = 300, relative = true }))

hl.unbind("SUPER + mouse_down")
o.bind("ALT + mouse_down", "Scroll active workspace forward", hl.dsp.focus({ workspace = "e+1" }))

hl.unbind("SUPER + mouse_up")
o.bind("ALT + mouse_up", "Scroll active workspace backward", hl.dsp.focus({ workspace = "e-1" }))

hl.unbind("SUPER + mouse:272")
o.bind("ALT + mouse:272", "Move window", hl.dsp.window.drag())

hl.unbind("SUPER + mouse:273")
o.bind("ALT + mouse:273", "Resize window", hl.dsp.window.resize())

hl.unbind("SUPER + G")
o.bind("ALT + G", "Toggle window grouping", hl.dsp.group.toggle())

hl.unbind("SUPER + ALT + G")
o.bind("ALT + SUPER + G", "Move active window out of group", hl.dsp.window.move({ out_of_group = true }))

hl.unbind("SUPER + ALT + LEFT")
o.bind("ALT + SUPER + LEFT", "Move window to group on left", hl.dsp.window.move({ into_group = "l" }))

hl.unbind("SUPER + ALT + RIGHT")
o.bind("ALT + SUPER + RIGHT", "Move window to group on right", hl.dsp.window.move({ into_group = "r" }))

hl.unbind("SUPER + ALT + UP")
o.bind("ALT + SUPER + UP", "Move window to group on top", hl.dsp.window.move({ into_group = "u" }))

hl.unbind("SUPER + ALT + DOWN")
o.bind("ALT + SUPER + DOWN", "Move window to group on bottom", hl.dsp.window.move({ into_group = "d" }))

hl.unbind("SUPER + ALT + TAB")
o.bind("ALT + SUPER + TAB", "Next window in group", hl.dsp.group.next())

hl.unbind("SUPER + ALT + SHIFT + TAB")
o.bind("ALT + SHIFT + SUPER + TAB", "Previous window in group", hl.dsp.group.prev())

hl.unbind("SUPER + CTRL + LEFT")
o.bind("CTRL + ALT + LEFT", "Move grouped window focus left", hl.dsp.group.prev())

hl.unbind("SUPER + CTRL + RIGHT")
o.bind("CTRL + ALT + RIGHT", "Move grouped window focus right", hl.dsp.group.next())

hl.unbind("SUPER + ALT + mouse_down")
o.bind("ALT + SUPER + mouse_down", "Next window in group", hl.dsp.group.next())

hl.unbind("SUPER + ALT + mouse_up")
o.bind("ALT + SUPER + mouse_up", "Previous window in group", hl.dsp.group.prev())

hl.unbind("SUPER + ALT + code:10")
o.bind("ALT + SUPER + code:10", "Switch to group window 1", hl.dsp.group.active({ index = 1 }))

hl.unbind("SUPER + ALT + code:11")
o.bind("ALT + SUPER + code:11", "Switch to group window 2", hl.dsp.group.active({ index = 2 }))

hl.unbind("SUPER + ALT + code:12")
o.bind("ALT + SUPER + code:12", "Switch to group window 3", hl.dsp.group.active({ index = 3 }))

hl.unbind("SUPER + ALT + code:13")
o.bind("ALT + SUPER + code:13", "Switch to group window 4", hl.dsp.group.active({ index = 4 }))

hl.unbind("SUPER + ALT + code:14")
o.bind("ALT + SUPER + code:14", "Switch to group window 5", hl.dsp.group.active({ index = 5 }))

hl.unbind("SUPER + SLASH")
o.bind("ALT + SLASH", "Monitor scaling up", "omarchy-hyprland-monitor-scaling up")

hl.unbind("SUPER + ALT + SLASH")
o.bind("ALT + SUPER + SLASH", "Monitor scaling down", "omarchy-hyprland-monitor-scaling down")

hl.unbind("SUPER + RETURN")
o.bind("ALT + RETURN", "Terminal", { omarchy = "terminal" })

hl.unbind("SUPER + SHIFT + RETURN")
o.bind("ALT + SHIFT + RETURN", "Browser", { omarchy = "browser" })

hl.unbind("SUPER + SHIFT + F")
o.bind("ALT + SHIFT + F", "File manager", { omarchy = "nautilus" })

hl.unbind("SUPER + ALT + SHIFT + F")
o.bind("ALT + SHIFT + SUPER + F", "File manager (cwd)", { omarchy = "nautilus-cwd" })

hl.unbind("SUPER + SHIFT + B")
o.bind("ALT + SHIFT + B", "Browser", { omarchy = "browser" })

hl.unbind("SUPER + SHIFT + ALT + B")
o.bind("ALT + SHIFT + SUPER + B", "Browser (private)", { omarchy = "browser --private" })

hl.unbind("SUPER + SHIFT + N")
o.bind("ALT + SHIFT + N", "Editor", { omarchy = "editor" })

hl.unbind("SUPER + ALT + RETURN")
o.bind("ALT + SUPER + RETURN", "Tmux", { omarchy = "terminal-tmux" })

hl.unbind("SUPER + CTRL + RETURN")
o.bind("CTRL + ALT + RETURN", "Herdr", { omarchy = "terminal-herdr" })

hl.unbind("SUPER + SHIFT + M")
o.bind("ALT + SHIFT + M", "Music", { omarchy = "spotify" })

hl.unbind("SUPER + SHIFT + ALT + M")
o.bind("ALT + SHIFT + SUPER + M", "Music TUI", { tui = "cliamp", focus = true })

-- kept on SUPER (ALT slot taken): SUPER + SHIFT + D -> "Docker"
hl.unbind("SUPER + SHIFT + G")
o.bind("ALT + SHIFT + G", "Signal", { omarchy = "signal" })

hl.unbind("SUPER + SHIFT + O")
o.bind("ALT + SHIFT + O", "Obsidian", { launch = "obsidian", focus = "^obsidian$" })

-- kept on SUPER (ALT slot taken): SUPER + SHIFT + W -> "Omawrite"
hl.unbind("SUPER + SHIFT + SLASH")
o.bind("ALT + SHIFT + SLASH", "Passwords", { omarchy = "1password" })

-- kept on SUPER (ALT slot taken): SUPER + SHIFT + A -> "ChatGPT"
hl.unbind("SUPER + SHIFT + ALT + A")
o.bind("ALT + SHIFT + SUPER + A", "Grok", { webapp = "https://grok.com" })

hl.unbind("SUPER + SHIFT + C")
o.bind("ALT + SHIFT + C", "Calendar", { webapp = "https://app.hey.com/calendar/weeks/" })

hl.unbind("SUPER + SHIFT + E")
o.bind("ALT + SHIFT + E", "Email", { webapp = "https://app.hey.com" })

hl.unbind("SUPER + SHIFT + ALT + E")
o.bind("ALT + SHIFT + SUPER + E", "New email", { webapp = "https://app.hey.com/messages/new?display=standalone&new_window=true" })

hl.unbind("SUPER + SHIFT + Y")
o.bind("ALT + SHIFT + Y", "YouTube", { webapp = "https://youtube.com/" })

hl.unbind("SUPER + SHIFT + ALT + G")
o.bind("ALT + SHIFT + SUPER + G", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = true })

hl.unbind("SUPER + SHIFT + CTRL + G")
o.bind("CTRL + ALT + SHIFT + G", "Google Messages", { webapp = "https://messages.google.com/web/conversations", focus = true })

hl.unbind("SUPER + SHIFT + P")
o.bind("ALT + SHIFT + P", "Google Photos", { webapp = "https://photos.google.com/", focus = true })

-- kept on SUPER (ALT slot taken): SUPER + SHIFT + S -> "Google Maps"
hl.unbind("SUPER + SHIFT + X")
o.bind("ALT + SHIFT + X", "X", { webapp = "https://x.com/" })

hl.unbind("SUPER + SHIFT + ALT + X")
o.bind("ALT + SHIFT + SUPER + X", "X Post", { webapp = "https://x.com/compose/post" })

hl.unbind("SUPER + CTRL + V")
o.bind("CTRL + ALT + V", "Clipboard manager", "omarchy-shell shell toggle omarchy.clipboard")

hl.unbind("SUPER + SPACE")
o.bind("ALT + SPACE", "Omarchy menu", "omarchy-menu toggle")

hl.unbind("SUPER + ALT + SPACE")
o.bind("ALT + SUPER + SPACE", "Apps menu", "omarchy-menu toggle apps")

hl.unbind("SUPER + CTRL + E")
o.bind("CTRL + ALT + E", "Emojis", "omarchy-shell shell toggle omarchy.emojis")

hl.unbind("SUPER + CTRL + C")
o.bind("CTRL + ALT + C", "Capture menu", "omarchy-menu toggle capture")

hl.unbind("SUPER + CTRL + O")
o.bind("CTRL + ALT + O", "Toggle menu", "omarchy-menu toggle toggle")

hl.unbind("SUPER + CTRL + H")
o.bind("CTRL + ALT + H", "Hardware menu", "omarchy-menu toggle hardware")

hl.unbind("SUPER + SHIFT + code:201")
o.bind("ALT + SHIFT + code:201", "Omarchy menu (root)", "omarchy-menu toggle root")

hl.unbind("SUPER + ESCAPE")
o.bind("ALT + ESCAPE", "System menu", "omarchy-menu toggle system")

-- kept on SUPER (ALT slot taken): SUPER + K -> "Keybindings"
hl.unbind("SUPER + ALT + K")
o.bind("ALT + SUPER + K", "Tmux keybindings", "omarchy-menu-tmux-keybindings")

hl.unbind("SUPER + CTRL + K")
o.bind("CTRL + ALT + K", "Herdr keybindings", "omarchy-menu-herdr-keybindings")

hl.unbind("SUPER + CTRL + Q")
o.bind("CTRL + ALT + Q", "Calculator", "omacalc")

hl.unbind("SUPER + SHIFT + SPACE")
o.bind_toggle("ALT + SHIFT + SPACE", "Toggle top bar", "bar")

hl.unbind("SUPER + CTRL + SPACE")
o.bind("CTRL + ALT + SPACE", "Background switcher", "omarchy-menu toggle background")

hl.unbind("SUPER + SHIFT + CTRL + SPACE")
o.bind("CTRL + ALT + SHIFT + SPACE", "Theme menu", "omarchy-menu toggle theme")

hl.unbind("SUPER + BACKSPACE")
o.bind("ALT + BACKSPACE", "Toggle window transparency", "omarchy-hyprland-window-transparency-toggle")

hl.unbind("SUPER + SHIFT + BACKSPACE")
o.bind("ALT + SHIFT + BACKSPACE", "Toggle window gaps", "omarchy-hyprland-window-gaps-toggle")

hl.unbind("SUPER + CTRL + BACKSPACE")
o.bind("CTRL + ALT + BACKSPACE", "Toggle single-window square aspect", "omarchy-hyprland-window-single-square-aspect-toggle")

hl.unbind("SUPER + comma")
o.bind("ALT + comma", "Dismiss last notification", "omarchy-shell notifications dismissOne")

hl.unbind("SUPER + SHIFT + comma")
o.bind("ALT + SHIFT + comma", "Dismiss all notifications", "omarchy-shell notifications dismissAll")

hl.unbind("SUPER + CTRL + comma")
o.bind_toggle("CTRL + ALT + comma", "Toggle silencing notifications", "notification-silencing")

hl.unbind("SUPER + ALT + comma")
o.bind("ALT + SUPER + comma", "Invoke last notification", "omarchy-shell notifications invokeLast")

hl.unbind("SUPER + SHIFT + ALT + comma")
o.bind("ALT + SHIFT + SUPER + comma", "Open notification history", "omarchy-shell notifications showHistory")

hl.unbind("SUPER + CTRL + I")
o.bind_toggle("CTRL + ALT + I", "Toggle locking on idle", "idle")

hl.unbind("SUPER + CTRL + N")
o.bind_toggle("CTRL + ALT + N", "Toggle nightlight", "nightlight")

-- kept on SUPER (ALT slot taken): SUPER + CTRL + Delete -> "Toggle laptop display"
hl.unbind("SUPER + CTRL + ALT + Delete")
o.bind("CTRL + ALT + SUPER + Delete", "Toggle laptop display mirroring", "omarchy-hyprland-monitor-internal-mirror toggle")

hl.unbind("SUPER + ALT + code:34")
o.bind("ALT + SUPER + code:34", "Make webcam overlay smaller", "omarchy-capture-webcam-resize smaller")

hl.unbind("SUPER + ALT + code:35")
o.bind("ALT + SUPER + code:35", "Make webcam overlay larger", "omarchy-capture-webcam-resize larger")

-- kept on SUPER (ALT slot taken): SUPER + PRINT -> "Color picker"
hl.unbind("SUPER + CTRL + PRINT")
o.bind("CTRL + ALT + PRINT", "Extract text (OCR) from screenshot", "omarchy-capture-text")

hl.unbind("SUPER + CTRL + S")
o.bind("CTRL + ALT + S", "Share", "omarchy-menu toggle share")

hl.unbind("SUPER + CTRL + PERIOD")
o.bind("CTRL + ALT + PERIOD", "Transcode", "omarchy-transcode")

hl.unbind("SUPER + CTRL + R")
o.bind("CTRL + ALT + R", "Set reminder", "omarchy-menu toggle reminder-set")

hl.unbind("SUPER + CTRL + ALT + R")
o.bind("CTRL + ALT + SUPER + R", "Show reminders", "omarchy-reminder show")

hl.unbind("SUPER + SHIFT + CTRL + R")
o.bind("CTRL + ALT + SHIFT + R", "Clear reminders", "omarchy-reminder clear")

hl.unbind("SUPER + CTRL + ALT + T")
o.bind("CTRL + ALT + SUPER + T", "Show time", "omarchy-notification-time")

hl.unbind("SUPER + CTRL + ALT + B")
o.bind("CTRL + ALT + SUPER + B", "Show battery remaining", "omarchy-notification-battery")

hl.unbind("SUPER + CTRL + ALT + W")
o.bind("CTRL + ALT + SUPER + W", "Toggle weather", "omarchy-notification-weather")

hl.unbind("SUPER + SHIFT + CTRL + A")
o.bind("CTRL + ALT + SHIFT + A", "Agent", "omarchy-agent --pick")

hl.unbind("SUPER + CTRL + A")
o.bind("CTRL + ALT + A", "Audio", "omarchy-shell shell toggle omarchy.audio")

hl.unbind("SUPER + CTRL + B")
o.bind("CTRL + ALT + B", "Bluetooth", "omarchy-shell shell toggle omarchy.bluetooth")

hl.unbind("SUPER + CTRL + D")
o.bind("CTRL + ALT + D", "Display", "omarchy-shell shell toggle omarchy.monitor")

hl.unbind("SUPER + CTRL + ALT + D")
o.bind("CTRL + ALT + SUPER + D", "Calendar (widget)", "omarchy-shell shell toggle omarchy.clock")

hl.unbind("SUPER + CTRL + W")
o.bind("CTRL + ALT + W", "Network", "omarchy-shell shell toggle omarchy.network")

hl.unbind("SUPER + CTRL + P")
o.bind("CTRL + ALT + P", "Power", "omarchy-shell shell toggle omarchy.power")

hl.unbind("SUPER + CTRL + T")
o.bind("CTRL + ALT + T", "Activity", { tui = "btop" })

hl.unbind("SUPER + CTRL + code:10")
o.bind("CTRL + ALT + code:10", "Bar panel 1", "omarchy-shell -q shell togglePanelAt right 1")

hl.unbind("SUPER + CTRL + code:11")
o.bind("CTRL + ALT + code:11", "Bar panel 2", "omarchy-shell -q shell togglePanelAt right 2")

hl.unbind("SUPER + CTRL + code:12")
o.bind("CTRL + ALT + code:12", "Bar panel 3", "omarchy-shell -q shell togglePanelAt right 3")

hl.unbind("SUPER + CTRL + code:13")
o.bind("CTRL + ALT + code:13", "Bar panel 4", "omarchy-shell -q shell togglePanelAt right 4")

hl.unbind("SUPER + CTRL + code:14")
o.bind("CTRL + ALT + code:14", "Bar panel 5", "omarchy-shell -q shell togglePanelAt right 5")

hl.unbind("SUPER + CTRL + code:15")
o.bind("CTRL + ALT + code:15", "Bar panel 6", "omarchy-shell -q shell togglePanelAt right 6")

hl.unbind("SUPER + CTRL + code:16")
o.bind("CTRL + ALT + code:16", "Bar panel 7", "omarchy-shell -q shell togglePanelAt right 7")

hl.unbind("SUPER + CTRL + code:17")
o.bind("CTRL + ALT + code:17", "Bar panel 8", "omarchy-shell -q shell togglePanelAt right 8")

hl.unbind("SUPER + CTRL + code:18")
o.bind("CTRL + ALT + code:18", "Bar panel 9", "omarchy-shell -q shell togglePanelAt right 9")

hl.unbind("SUPER + CTRL + Z")
o.bind("CTRL + ALT + Z", "Zoom in", function()
  local zoom = hl.get_config("cursor.zoom_factor") or 1
  hl.config({ cursor = { zoom_factor = zoom + 1 } })
end)

hl.unbind("SUPER + CTRL + ALT + Z")
o.bind("CTRL + ALT + SUPER + Z", "Reset zoom", function()
  hl.config({ cursor = { zoom_factor = 1 } })
end)

hl.unbind("SUPER + CTRL + L")
o.bind("CTRL + ALT + L", "Lock system", "omarchy-system-lock")

hl.unbind("SUPER + CTRL + X")
o.bind("CTRL + ALT + X", "Toggle dictation", "voxtype record toggle")


-- Clipboard (ALT versions) — self-contained copy of the default helpers,
-- since the originals in default/hypr/bindings/clipboard.lua are local.
local function send_shortcut_once_alt(mods, key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))
    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

local function active_window_is_terminal_alt()
  local window = hl.get_active_window()
  if not window then return false end
  for _, tag in ipairs(window.tags or {}) do
    if tag:gsub("%*$", "") == "terminal" then return true end
  end
  return false
end

local function universal_clipboard_shortcut_alt(default_mods, default_key, terminal_mods, terminal_key)
  return function()
    if active_window_is_terminal_alt() then
      send_shortcut_once_alt(terminal_mods, terminal_key)()
    else
      send_shortcut_once_alt(default_mods, default_key)()
    end
  end
end

hl.unbind("SUPER + C")
o.bind("ALT + C", "Universal copy", universal_clipboard_shortcut_alt("CTRL", "C", "CTRL", "Insert"))
hl.unbind("SUPER + V")
o.bind("ALT + V", "Universal paste", universal_clipboard_shortcut_alt("CTRL", "V", "SHIFT", "Insert"))
hl.unbind("SUPER + X")
o.bind("ALT + X", "Universal cut", send_shortcut_once_alt("CTRL", "X"))
-- Note: "Clipboard manager" (SUPER+CTRL+V) is already converted above,
-- in the automatically generated block (-> CTRL + ALT + V).
