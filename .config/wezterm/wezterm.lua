local wez = require("wezterm")
local config = wez.config_builder()
local keybinds = require("keybinds")
config.keys = keybinds
config.color_scheme_dirs = { "~/.config/wezterm/colors" }

-- config.color_scheme = "Emerald Glow"
config.color_scheme = "Noir"
-- all of the above are my own colorschemes

-- config.color_scheme = "tokyonight_night"
-- config.color_scheme = "Dracula"
-- config.color_scheme = 'Abernathy'
-- config.color_scheme = 'Aci (Gogh)'
-- config.color_scheme = 'Argonaut'

config.font = wez.font("JetBrainsMonoNL Nerd Font", { weight = "DemiBold" })
config.font_size = 10
config.freetype_interpreter_version = 35
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"

config.animation_fps = 60
config.scrollback_lines = 5000
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 1
-- config.window_decorations = "RESIZE"
config.initial_rows = 30
config.initial_cols = 120
config.enable_wayland = false

-- NOTE: use when having issues when finding name of the key for keybinds
-- config.debug_key_events = true

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
	key = "w",
	mods = "ALT",
	timeout_milliseconds = 1500,
}
return config
