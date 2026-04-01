local wezterm = require 'wezterm'

local config = wezterm.config_builder()
local action = wezterm.action

local function get_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end
    return "Dark"
end

local function detect_mode()
    local appearance = get_appearance()
    if appearance:find("Light") then
        return "light"
    end
    return "dark"
end

local themes = {
    light = {
        color_scheme = "iTerm2 Tango Light",

        window_frame = {
            active_titlebar_bg = "#eaeaea",
            active_titlebar_fg = "#222222",
            inactive_titlebar_bg = "#f3f3f3",
            inactive_titlebar_fg = "#666666",
            active_titlebar_border_bottom = "#d0d0d0",
            inactive_titlebar_border_bottom = "#d0d0d0",
            button_bg = "#eaeaea",
            button_fg = "#222222",
            button_hover_bg = "#dcdcdc",
            button_hover_fg = "#000000",
        },

        tab_bar = {
            background = "#f3f3f3",

            active_tab = {
                bg_color = "#e0e0e0",
                fg_color = "#222222",
                intensity = "Normal",
            },

            inactive_tab = {
                bg_color = "#f3f3f3",
                fg_color = "#777777",
            },

            inactive_tab_hover = {
                bg_color = "#e6e6e6",
                fg_color = "#444444",
                italic = true,
            },

            new_tab = {
                bg_color = "#f3f3f3",
                fg_color = "#777777",
            },

            new_tab_hover = {
                bg_color = "#e6e6e6",
                fg_color = "#444444",
                italic = true,
            },
        },
    },
    dark = {
        color_scheme = "GruvboxDarkHard",

        window_frame = {
            active_titlebar_bg = "#1c1c1c",
            active_titlebar_fg = "#e0e0e0",
            inactive_titlebar_bg = "#141414",
            inactive_titlebar_fg = "#a0a0a0",
            active_titlebar_border_bottom = "#2a2a2a",
            inactive_titlebar_border_bottom = "#202020",
            button_bg = "#1c1c1c",
            button_fg = "#a0a0a0",
            button_hover_bg = "#2a2a2a",
            button_hover_fg = "#ffffff",
        },

        tab_bar = {
            background = "#141414",

            active_tab = {
                bg_color = "#2a2a2a",
                fg_color = "#e0e0e0",
                intensity = "Normal",
            },

            inactive_tab = {
                bg_color = "#1c1c1c",
                fg_color = "#808080",
            },

            inactive_tab_hover = {
                bg_color = "#303030",
                fg_color = "#c0c0c0",
                italic = true,
            },

            new_tab = {
                bg_color = "#1c1c1c",
                fg_color = "#808080",
            },

            new_tab_hover = {
                bg_color = "#303030",
                fg_color = "#c0c0c0",
                italic = true,
            },
        },
    },
}

local mode = detect_mode()
local theme = themes[mode]

config.color_scheme = theme.color_scheme
config.window_frame = theme.window_frame
config.colors = {
    tab_bar = theme.tab_bar,
}

config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font {
    family = 'Fira Code',
    weight = 'Medium',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
}

config.font_size = 14
config.line_height = 1.0

config.window_padding = {
    left = '0.5cell',
    right = '0.5cell',
    top = '0.5cell',
    bottom = '0.5cell',
}

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

return config
