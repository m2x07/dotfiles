local wezterm = require "wezterm"
local act = wezterm.action
local M

M = {
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
	},
	{
		key = "-",
		mods = "LEADER",
		action = act.SplitVertical { domain = "CurrentPaneDomain" },
	},
    {
        key= 't',
        mods = 'LEADER',
        action = act.SpawnTab 'CurrentPaneDomain'
    },
    {
        key = 'n',
        mods = 'LEADER',
        action = act.ActivateTabRelative(1)
    },
    {
        key = 'p',
        mods = 'LEADER',
        action = act.ActivateTabRelative(-1)
    },
    {
        key = 'w',
        mods = 'LEADER',
        action = act.ShowTabNavigator,
    }
}

return M
