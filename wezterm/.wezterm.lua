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
-- FIXME:
-- set-option -g default-command "fish"
-- # Optional: for login shell behavior
-- # set-option -g default-command "fish -l"
-- This lets tmux fall back to your user's default shell or $SHELL, but runs fish explicitly.
-- Often works better with fish and avoids path issues.
--
-- After nix changes:
--
-- Reload config: tmux source-file ~/.tmux.conf (if inside tmux) or restart server.
-- Or just tmux kill-server && tmux new-session.
--
-- /ENDFIXME
--
-- For now, we are sticking with the system path to fish
-- Spawn a fish shell in login mode
-- this path *should* always have a valid pointer to the active fish install, but stick to resolving fish by PATH
-- remember: nix is handling our paths for us - don't get in the way :)
config.default_prog = { '/run/current-system/sw/bin/fish', '-l' }
-- trying to just use `fish` doesnt work -- the path is limited on startup.
-- config.default_prog = { 'fish', '-l' }

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'Catppuccin Frappe'
-- config.color_scheme = 'catppuccin-macchiato' -- good for default text and im just about that catppuccin life
-- config.color_scheme = 'Catppuccin Macchiato' -- good for default text and im just about that catppuccin life
-- config.color_scheme = 'Ciapre' -- easier to read default (white) text
-- config.color_scheme = 'Dracula'
config.color_scheme = 'duckbones'
-- config.color_scheme = 'duskfox' -- very good!

config.colors = {
  cursor_bg = "#236D5F",
  -- cursor_bg = "#212134",
  cursor_fg = "#000",
}

-- transparency
config.window_background_opacity = 0.85;
config.macos_window_background_blur = 30
config.text_background_opacity = 0.3

-- font
config.font = wezterm.font 'JetBrains Mono'
-- config.font = wezterm.font 'MonoLisa'
config.font_size = 14

-- window options
config.window_decorations = "RESIZE"
config.native_macos_fullscreen_mode = true
config.tab_bar_at_bottom = false
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

-- scrollback history per tab
config.scrollback_lines = 3500

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
