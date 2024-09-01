local wezterm = require("wezterm")
local act = wezterm.action

local M = {
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "t",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "n",
		mods = "LEADER",
		action = act.RotatePanes("Clockwise"),
	},
	{
		key = "p",
		mods = "LEADER",
		action = act.RotatePanes("CounterClockwise"),
	},
	{
		key = "w",
		mods = "LEADER",
		action = act.ShowTabNavigator,
	},
	{
		key = "0",
		mods = "LEADER",
		action = act.PaneSelect({
			alphabet = "1234567890",
		}),
	},
	{
		key = "Keypad9",
		mods = "CTRL",
		action = act.ScrollByPage(-1),
	},
	{
		key = "Keypad3",
		mods = "CTRL",
		action = act.ScrollByPage(1),
	},
	{
		key = "d",
		mods = "LEADER",
		action = act.ShowDebugOverlay,
	},
    {
        key = 'Keypad9',
        mods = 'CTRL|SHIFT',
        action = act.MoveTabRelative(-1)
    },
    {
        key = 'Keypad3',
        mods = 'CTRL|SHIFT',
        action = act.MoveTabRelative(1)
    },
}

return M
