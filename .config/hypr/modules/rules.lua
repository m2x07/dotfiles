--- WINDOW RULES ---
hl.window_rule({
	name = "fix-xwayland-dragging-issues",
	enabled = false,
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
        float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})
hl.window_rule({
	name = "zen-pip",
	match = {
		class = "zen",
		title = "Picture-in-Picture",
	},
	float = true,
	size = "monitor_w*0.5 monitor_h*0.5",
	center = true,
})
hl.window_rule({
	name = "zen-library",
	match = {
		class = "zen",
		title = "Library",
	},
	float = true,
	size = "monitor_w*0.75 monitor_h*0.75",
	center = true,
})
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ match = { float = true }, no_shadow = true, center = true })
hl.window_rule({ match = { class = "org.gnome.Calculator" }, float = true })
hl.window_rule({ match = { class = "it.mojorus.smile" }, float = true })

--- LAYER RULES ---
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })
hl.layer_rule({ match = { namespace = "hyprpicker" }, no_anim = true })
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "walker" }, no_anim = true })
