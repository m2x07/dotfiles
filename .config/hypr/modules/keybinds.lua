local browser = "zen-browser"
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "walker"
local captureDisplay = "hyprshot -m output --freeze"
local captureRegion = "hyprshot -m region --freeze"
local captureWindow = "hyprshot -m window --freeze"
local newWall = "$HOME/.local/bin/wallrefresh.sh"
local mainMod = "SUPER"

-- Keybinds for general programs
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("uwsm-app -- " .. terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("uwsm-app -- " .. browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm-app -- " .. fileManager))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(newWall))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("hyprlock"))

-- Keybinds for general actions
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("wlogout"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd('loginctl terminate-user ""'))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + C", hl.dsp.window.center())
hl.bind("ALT + TAB", hl.dsp.focus({ last = true }))
hl.bind(mainMod .. " + n", hl.dsp.window.cycle_next())

-- Keybinds for screenshots
hl.bind("Print", hl.dsp.exec_cmd(captureRegion))
hl.bind("ALT + Print", hl.dsp.exec_cmd(captureWindow))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(captureDisplay))

-- Keybinds for changing focused window
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Keybinds for moving windows around
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- Keybinds for resizing windows
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -15, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 15, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 15, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -15, relative = true }), { repeating = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Keybinds for moving around workspaces
hl.bind(mainMod .. " + KP_Prior", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + KP_Next", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

-- Keybinds for special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Keybinds for volume control
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

-- Keybinds for brightness control
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { locked = true, repeating = true })

-- Keybinds for media control
hl.bind("ALT + F1", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("ALT + F2", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("ALT + F3", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
