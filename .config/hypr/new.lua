---@diagnostic disable: unused-local
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({ output = "eDP-1", mode = "1920x1080@144", position = "0x0", scale = 1 })

local browser = "zen-browser"
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "walker"
local captureDisplay = "hyprshot -m output --freeze"
local captureRegion = "hyprshot -m region --freeze"
local captureWindow = "hyprshot -m window --freeze"
local newWall = "$HOME/.local/bin/wallrefresh.sh"

hl.on("hyprland.start", function()
	hl.exec_cmd("sleep 1; " .. newWall)
end)
hl.on("config.reloaded", function()
	hl.exec_cmd("killall waybar; waybar")
	hl.exec_cmd("pkill elephant; elephant")
	hl.exec_cmd("pkill walker; GSK_RENDERER=cairo walker --gapplication-service")
end)

hl.config({
	general = {
		border_size = 1,
		gaps_in = 4,
		gaps_out = 8,
		col = {
			active_border = "rgba(120,120,120,1.0)",
			inactive_border = "rgba(68,68,68,0.7)",
		},
		layout = "dwindle",
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
	animations = {
		enabled = true,
	},
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
	misc = {
		font_family = "Maple Mono NF NL CN",
		splash_font_family = "Maple Mono NF NL CN",
	},
	dwindle = {
		preserve_split = true,
	},
})

local mainMod = "SUPER"
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("uwsm-app -- " .. terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("uwsm-app -- " .. browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm-app -- " .. fileManager))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(newWall))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd('loginctl terminate-user ""'))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + C", hl.dsp.window.center())
---@diagnostic disable-next-line: undefined-global
hl.bind(mainMod .. " + ALT + TAB", hl.dsp.focus({ last }))
hl.bind(mainMod .. " + n", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("wlogout"))

hl.bind("Print", hl.dsp.exec_cmd(captureRegion))
hl.bind("ALT + Print", hl.dsp.exec_cmd(captureWindow))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(captureDisplay))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ -15, 0 }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ 15, 0 }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ 0, 15 }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ 0, -15 }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + KP_Prior", hl.dsp.workspace.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + KP_Next", hl.dsp.workspace.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.workspace.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.workspace.move({ workspace = "e+1" }))

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { locked = true, repeating = true })

hl.bind("ALT + F1", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("ALT + F2", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("ALT + F3", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "easeOutQuint" })
hl.animation({ leaf = "border", enabled = false })
hl.animation({ leaf = "borderangle", enabled = false })
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "easeOutQuint", style = "popin 50%" })
hl.animation({ leaf = "fade", enabled = true, speed = 1, bezier = "quick" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2, bezier = "quick" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.5, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slidefadevert 20%" })

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

hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "walker" }, no_anim = true })
