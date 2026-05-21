local newWall = "$HOME/.local/bin/wallrefresh.sh"

hl.on("hyprland.start", function()
	hl.exec_cmd("sleep 1; " .. newWall)
end)
hl.on("config.reloaded", function()
	hl.exec_cmd("killall waybar; waybar")
	hl.exec_cmd("pkill elephant; elephant")
	hl.exec_cmd("pkill walker; GSK_RENDERER=cairo walker --gapplication-service")
end)

hl.on("config.reloaded", function()
	hl.notification.create({
        text = "Hyprland config has been reloaded",
		timeout = 5000,
		icon = "ok",
	})
end)
