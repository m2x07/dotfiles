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
		key = "k",
		mods = "CTRL",
		action = act.ScrollByPage(-1),
	},
	{
		key = "j",
		mods = "CTRL",
		action = act.ScrollByPage(1),
	},
	{
		key = "d",
		mods = "LEADER",
		action = act.ShowDebugOverlay,
	},
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = act.MoveTabRelative(-1),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = act.MoveTabRelative(1),
	},
    {
        key = 'j',
        mods = "ALT|SHIFT",
        action = act.AdjustPaneSize { 'Down', 1 },
    },
    {
        key = 'k',
        mods = "ALT|SHIFT",
        action = act.AdjustPaneSize { 'Up', 1 },
    },
    {
        key = 'h',
        mods = "ALT|SHIFT",
        action = act.AdjustPaneSize { 'Left', 1 },
    },
    {
        key = 'l',
        mods = "ALT|SHIFT",
        action = act.AdjustPaneSize { 'Right', 1 },
    },
    {
        key = 'h',
        mods = "ALT",
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'j',
        mods = "ALT",
        action = act.ActivatePaneDirection 'Down',
    },
    {
        key = 'k',
        mods = "ALT",
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'l',
        mods = "ALT",
        action = act.ActivatePaneDirection 'Right',
    },
}

return M
