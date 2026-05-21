hl.config({
	general = {
		border_size = 1,
		gaps_in = 4,
		gaps_out = 8,
		col = {
			active_border = "rgba(120,120,120,1.0)",
			inactive_border = "rgba(68,68,68,0.7)",
		},
		resize_on_border = true,
	},
	decoration = {
		rounding = 7,
		rounding_power = 4.0,
		blur = {
			enabled = true,
			size = 8,
			passes = 2,
			vibrancy = 0.1696,
		},
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(0,0,0,1)",
		},
	},
	misc = {
		font_family = "Maple Mono NL NF CN",
		splash_font_family = "Maple Mono NF NL CN",
	},
})
