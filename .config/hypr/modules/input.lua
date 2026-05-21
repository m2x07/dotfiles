hl.config({
	input = {
		kb_layout = "us",
		kb_options = "caps:ctrl_shifted_capslock",
		repeat_delay = 400,
		accel_profile = "flat",
		sensitivity = 0,
		follow_mouse = 1,
		focus_on_close = 0,
		scroll_factor = 1.0,

		touchpad = {
			natural_scroll = true,
			drag_lock = 1,
			scroll_factor = 0.5,
		},
	},
	gestures = {
		workspace_swipe_distance = 500,
		workspace_swipe_create_new = true,
	},
})
hl.device({
	name = "asue120b:00-04f3:31c0-touchpad",
	sensitivity = 0.5,
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.gesture({
	fingers = 2,
	direction = "pinchin",
	action = "float",
})
