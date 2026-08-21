-- Omarchy 4 custom look & feel
-- Smooth animations + rounded corners + blur + shadows

-- =========================================================
-- GENERAL
-- =========================================================

hl.config({
  general = {
    -- Gaps between windows
    gaps_in = 6,
    gaps_out = 12,

    -- Border thickness
    border_size = 2,

    -- Keep Omarchy's normal layout
    layout = "dwindle",

    -- Resize windows by dragging their borders
    resize_on_border = false,

    -- Disable tearing
    allow_tearing = false,
  },
})


-- =========================================================
-- DECORATION
-- =========================================================

hl.config({
  decoration = {
    -- Rounded window corners
    rounding = 5,

    -- -----------------------------------------------------
    -- Shadows
    -- -----------------------------------------------------

    shadow = {
      enabled = true,

      -- Softer shadow
      range = 20,
      render_power = 3,

      -- Shadow color
      color = "rgba(00000055)",
    },

    -- -----------------------------------------------------
    -- Blur
    -- -----------------------------------------------------

    blur = {
      enabled = true,

      -- Blur strength
      size = 8,

      -- Number of blur passes
      passes = 2,

      -- Better looking blur
      new_optimizations = true,

      -- Blur behind transparent windows
      ignore_opacity = false,

      -- Respect window opacity
      xray = false,
    },
  },
})


-- =========================================================
-- ANIMATIONS
-- =========================================================

hl.config({
  animations = {
    enabled = false,
  },
})


-- =========================================================
-- ANIMATION CURVES
-- =========================================================

-- Smooth and elegant
hl.curve(
  "smooth",
  {
    type = "bezier",
    points = {
      { 0.23, 1 },
      { 0.32, 1 },
    },
  }
)

-- Smooth cubic movement
hl.curve(
  "smoothCubic",
  {
    type = "bezier",
    points = {
      { 0.65, 0.05 },
      { 0.36, 1 },
    },
  }
)

-- Fast start, smooth finish
hl.curve(
  "quick",
  {
    type = "bezier",
    points = {
      { 0.15, 0 },
      { 0.1, 1 },
    },
  }
)

-- Linear movement
hl.curve(
  "linear",
  {
    type = "bezier",
    points = {
      { 0, 0 },
      { 1, 1 },
    },
  }
)

-- =========================================================
-- GLOBAL ANIMATION
-- =========================================================

hl.animation({
  leaf = "global",
  enabled = true,
  speed = 10,
  bezier = "default",
})


-- =========================================================
-- WINDOW ANIMATIONS
-- =========================================================

-- Normal window movement
hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 3.8,
  bezier = "smooth",
})


-- Window opening
hl.animation({
  leaf = "windowsIn",
  enabled = true,
  speed = 4.2,
  bezier = "smooth",
  style = "popin 90%",
})


-- Window closing
hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 2.5,
  bezier = "quick",
  style = "popin 90%",
})


-- =========================================================
-- FADE ANIMATIONS
-- =========================================================

-- Fade in
hl.animation({
  leaf = "fadeIn",
  enabled = true,
  speed = 2,
  bezier = "smoothCubic",
})


-- Fade out
hl.animation({
  leaf = "fadeOut",
  enabled = true,
  speed = 1.7,
  bezier = "smoothCubic",
})


-- General fading
hl.animation({
  leaf = "fade",
  enabled = true,
  speed = 3,
  bezier = "quick",
})


-- Disable fade switching
hl.animation({
  leaf = "fadeSwitch",
  enabled = false,
})


-- =========================================================
-- LAYER ANIMATIONS
-- =========================================================

-- Menus, launchers and other layers
hl.animation({
  leaf = "layers",
  enabled = true,
  speed = 3.8,
  bezier = "smooth",
})


-- Layer opening
hl.animation({
  leaf = "layersIn",
  enabled = true,
  speed = 4,
  bezier = "smooth",
  style = "fade",
})


-- Layer closing
hl.animation({
  leaf = "layersOut",
  enabled = true,
  speed = 2,
  bezier = "quick",
  style = "fade",
})


-- Layer fade in
hl.animation({
  leaf = "fadeLayersIn",
  enabled = true,
  speed = 2,
  bezier = "smoothCubic",
})


-- Layer fade out
hl.animation({
  leaf = "fadeLayersOut",
  enabled = true,
  speed = 1.7,
  bezier = "smoothCubic",
})


-- =========================================================
-- WORKSPACE ANIMATIONS
-- =========================================================

-- Smooth workspace switching
hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 3,
  bezier = "smoothCubic",
})


-- =========================================================
-- DWINDLE
-- =========================================================

hl.config({
  dwindle = {
    preserve_split = true,
    force_split = 2,
  },
})


-- =========================================================
-- SCROLLING LAYOUT
-- =========================================================

hl.config({
  scrolling = {
    -- Width of columns when using scrolling layout
    column_width = 0.49,
  },
})


-- =========================================================
-- MASTER LAYOUT
-- =========================================================

hl.config({
  master = {
    new_status = "master",
  },
})


-- =========================================================
-- MISC
-- =========================================================

hl.config({
  misc = {
    -- Remove Hyprland logo
    disable_hyprland_logo = true,

    -- Remove splash screen
    disable_splash_rendering = true,

    -- Disable scaling notification
    disable_scale_notification = true,

    -- Focus activated windows
    focus_on_activate = true,

    -- Detect unresponsive applications
    anr_missed_pings = 3,

    -- Focus windows underneath fullscreen
    on_focus_under_fullscreen = 1,

    -- Workspace tracking
    initial_workspace_tracking = 0,

    -- Allow Omarchy's shell to recover the session lock
    allow_session_lock_restore = true,
  },
})


-- =========================================================
-- CURSOR
-- =========================================================

hl.config({
  cursor = {
    -- Hide cursor while typing
    hide_on_key_press = true,

    -- Move cursor when changing workspace
    warp_on_change_workspace = 1,
  },
})


-- =========================================================
-- BINDS
-- =========================================================

hl.config({
  binds = {
    -- Hide special workspace when changing workspace
    hide_special_on_workspace_change = true,
  },
})
