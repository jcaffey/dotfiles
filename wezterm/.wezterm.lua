-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- CONFIG CUSTOMIZATION STARTS HERE
-- ================================

-- Spawn a fish shell in login mode
config.default_prog = { '/usr/local/bin/fish', '-l' }

-- For example, changing the color scheme:
config.color_scheme = 'AdventureTime'

config.colors = {
  cursor_bg = "#FCEE0C"
}

-- transparency
config.window_background_opacity = 0.9
config.macos_window_background_blur = 60
config.text_background_opacity = 0.3

-- font
config.font = wezterm.font 'JetBrains Mono'
-- config.font = wezterm.font 'MonoLisa'
config.font_size = 18.0

-- window options
config.window_decorations = "RESIZE"
config.native_macos_fullscreen_mode = true
config.tab_bar_at_bottom = true
config.enable_tab_bar = false
config.enable_scroll_bar = false

config.keys = {
  -- Turn off the default CMD-m Hide action, allowing CMD-m to
  -- be potentially recognized and handled by the tab
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

-- and finally, return the configuration to wezterm
return config




-- DEFAULT CONFIG FOR DEBUGGING
-- ============================
-- -- Pull in the wezterm API
-- local wezterm = require 'wezterm'
--
-- -- This table will hold the configuration.
-- local config = {}
--
-- -- In newer versions of wezterm, use the config_builder which will
-- -- help provide clearer error messages
-- if wezterm.config_builder then
--   config = wezterm.config_builder()
-- end
--
-- return config
