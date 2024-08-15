local wez = require("wezterm")
local config = wez.config_builder()
local themes = require("themes")
local keybinds = require('keybinds')
config.color_schemes = themes
config.keys = keybinds

config.color_scheme = "m2x07-black"
-- config.color_scheme = 'Abernathy'
-- config.color_scheme = 'Aci (Gogh)'
-- config.color_scheme = 'Argonaut'
config.font_size = 11
config.animation_fps = 60
config.font = wez.font("MesloLGM Nerd Font", { weight = "Regular" })
config.scrollback_lines = 5000
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.85
config.window_decorations = "NONE"
config.initial_rows = 40

-- NOTE: use when having issues when finding name of the key for keybinds
config.debug_key_events = true

config.initial_cols = 115
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.inactive_pane_hsb = {
	brightness = 1,
	saturation = 1,
}
config.leader = {
    key = 'w',
    mods = 'CTRL',
    timeout_milliseconds = 1500,
}
return config
