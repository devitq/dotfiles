local wezterm = require 'wezterm'

local config = wezterm.config_builder()
local action = wezterm.action

config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font {
    family = 'Fira Code',
    weight = 'Medium',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- disable ligatures
}
config.line_height = 1.0
config.font_size = 14
config.color_scheme = 'GruvboxDarkHard'

config.window_padding = { left = '0.5cell', right = '0.5cell', top = '0.5cell', bottom = '0.5cell' }

-- config.window_background_image = '/Users/itq/Pictures/Wallpapers/basic.jpg'
-- config.window_background_image_hsb = {
--     -- Darken the background image by reducing it to 1/3rd
--     brightness = 0.3,
--
--     -- You can adjust the hue by scaling its value.
--     -- a multiplier of 1.0 leaves the value unchanged.
--     hue = 1.0,
--
--     -- You can adjust the saturation also.
--     saturation = 1.0,
-- }

config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

config.keys = {
    { key = 'd',          mods = 'CMD|SHIFT', action = action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'd',          mods = 'CMD',       action = action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'k',          mods = 'CMD',       action = action.ClearScrollback 'ScrollbackAndViewport' },
    { key = 'w',          mods = 'CMD',       action = action.CloseCurrentPane { confirm = false } },
    { key = 'w',          mods = 'CMD|SHIFT', action = action.CloseCurrentTab { confirm = false } },
    { key = 'LeftArrow',  mods = 'CMD',       action = action.SendKey { key = 'Home' } },
    { key = 'RightArrow', mods = 'CMD',       action = action.SendKey { key = 'End' } },
    { key = 'p',          mods = 'CMD|SHIFT', action = action.ActivateCommandPalette },
    {
        key = 'LeftArrow',
        mods = 'OPT',
        action = wezterm.action.SendString '\x1bb',
    },
    {
        key = 'RightArrow',
        mods = 'OPT',
        action = wezterm.action.SendString '\x1bf',
    },
}

config.default_cwd = '/Users/itq'

return config
