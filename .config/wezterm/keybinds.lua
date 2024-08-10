local wezterm = require "wezterm"
local M

M = {
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
	},
    {
        key= 't',
        mods = 'LEADER',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain'
    },
    {
        key = 'n',
        mods = 'LEADER',
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        key = 'p',
        mods = 'LEADER',
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        key = 'w',
        mods = 'LEADER',
        action = wezterm.action.ShowTabNavigator,
    },
}

return M
