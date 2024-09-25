local wez = require("wezterm")
local config = wez.config_builder()
local keybinds = require("keybinds")
config.keys = keybinds
local custom_themes = {
    ['m2x07_black'] = {
        foreground = "#ffffff",
        background = "#040811",
        cursor_fg = "#000000",
        cursor_bg = "#ffffff",
        cursor_border = "#ffffff",
        selection_bg = "#1a53ac",
        selection_fg = "#e6edf3",
        split="#333333",
        ansi = {
            "#000000",
            "#fc5555",
            "#5be599",
            "#fcfc14",
            "#0000ff",
            "#fc14ec",
            "#14f4fc",
            "#ffffff",
        },
        brights = {
            "#555555",
            "#fc5555",
            "#5be599",
            "#fcfc14",
            "#0000ff",
            "#fc14ec",
            "#14f4fc",
            "#ffffff",
        }
    }
}
config.color_scheme_dirs = { "~/.config/wezterm/colors" }
config.color_schemes = custom_themes
-- config.color_scheme = "m2x07_black"
config.color_scheme = "tokyonight_night"
-- config.color_scheme = "Dracula"
-- config.color_scheme = 'Abernathy'
-- config.color_scheme = 'Aci (Gogh)'
-- config.color_scheme = 'Argonaut'

config.font = wez.font("JetBrainsMonoNL Nerd Font", { weight = "Regular" })
config.font_size = 10
config.freetype_interpreter_version = 35
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"

config.animation_fps = 60
config.scrollback_lines = 5000
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 1
config.window_decorations = "NONE"
config.initial_rows = 30
config.initial_cols = 120

-- NOTE: use when having issues when finding name of the key for keybinds
config.debug_key_events = true

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
	key = "a",
	mods = "CTRL",
	timeout_milliseconds = 1500,
}
return config
