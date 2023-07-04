-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- Spawn a fish shell in login mode
config.default_prog = { '/usr/local/bin/fish', '-l' }

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'

-- transparency
config.window_background_opacity = 0.3
config.macos_window_background_blur = 60
config.text_background_opacity = 0.3
--font
config.font = wezterm.font 'MonoLisa Nerd Font Mono'
config.font_size = 24.0

-- window options
config.window_decorations = "RESIZE"
config.native_macos_fullscreen_mode = true
config.tab_bar_at_bottom = true
config.enable_tab_bar = false
config.enable_scroll_bar = true

-- and finally, return the configuration to wezterm
return config
