-- Pull in the wezterm API
local wezterm = require("wezterm")
-- This will hold the configuration.
local config = wezterm.config_builder()
-- The font to use globally
local g_font = wezterm.font({ family = "FiraCode Nerd Font Mono", weight = "Regular" })

config.front_end = "OpenGL"
config.max_fps = 144
config.default_cursor_style = "SteadyBlock"
config.animation_fps = 1
config.term = "xterm-256color:RGB" -- Set the terminal type

-- Set font
config.font = g_font
-- Color scheme change
config.bold_brightens_ansi_colors = "BrightOnly"
config.color_scheme = "tokyonight_night"
-- Window opacity
config.window_background_opacity = 0.9

-- Window padding
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

-- Window frame styling
config.window_frame = {
	font = g_font,
	active_titlebar_bg = "#0c0b0f",
	-- active_titlebar_bg = "#181616",
}

-- tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_decorations = "NONE | RESIZE"
config.default_prog = { "wsl.exe", "~", "-d", "Ubuntu" }
config.initial_cols = 80

-- and finally, return the configuration to wezterm
return config
