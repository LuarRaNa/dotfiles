-- Theme Configuration
-- Rose Pine Dawn, from Zed Colors

local palette = {
    base = "#191724",
    surface = "#fffaf3",
    overlay = "#f2e9e1",
    muted = "#9893a5",
    subtle = "#797593",
    text = "#e0def4",
    love = "#b4637a",
    gold = "#ea9d34",
    rose = "#d7827e",
    pine = "#286983",
    foam = "#56949f",
    iris = "#907aa9",
    highlight_low = "#f4ede8",
    highlight_med = "#dfdad9",
    highlight_high = "#cecacd",
    -- Zed Colors
    background = "#faf4ed",
    black = "#faf4ed",
    blue = "#57949f",
    bright_black = "#b8b2ba",
    bright_blue = "#acc9ce",
    bright_cyan = "#97b1c0",
    bright_foreground = "#575279",
    bright_green = "#a5d5c5",
    bright_magenta = "#bcb1bd",
    bright_red = "#dcb0bb",
    bright_white = "#575279",
    bright_yellow = "#fccd9b",
    cyan = "#296983",
    dim_black = "#575279",
    dim_blue = "#2f484d",
    dim_cyan = "#1b3541",
    dim_foreground = "#faf4ed",
    dim_green = "#265245",
    dim_magenta = "#3e353f",
    dim_red = "#57333d",
    dim_white = "#827e98",
    dim_yellow = "#854a1e",
    foreground = "#575279",
    green = "#3daa8e",
    magenta = "#7c697f",
    red = "#b4647a",
    white = "#575279",
    yellow = "#e99d35"

}

local active_tab = {
    bg_color = palette.overlay,
    fg_color = palette.text,
}

local inactive_tab = {
    bg_color = palette.base,
    fg_color = palette.muted,
}

function colors()
    return {
        foreground = palette.foreground,
        background = palette.background,
        cursor_bg = palette.muted,
        cursor_border = palette.muted,
        cursor_fg = palette.text,
        selection_bg = palette.overlay,
        selection_fg = palette.text,
        ansi = {
            palette.black,
            palette.red,
            palette.green,
            palette.yellow,
            palette.blue,
            palette.magenta,
            palette.cyan,
            palette.white,
        },
        brights = {
            palette.bright_black,
            palette.bright_red,
            palette.bright_green,
            palette.bright_yellow,
            palette.bright_blue,
            palette.bright_magenta,
            palette.bright_cyan,
            palette.bright_white
        },
        -- indexed = {
            -- [259] = palette.dim_black,
            -- [260] = palette.dim_red,
            -- [261] = palette.dim_green,
            -- [262] = palette.dim_yellow,
            -- [263] = palette.dim_blue,
            -- [264] = palette.dim_magenta,
            -- [265] = palette.dim_cyan,
            -- [266] = palette.dim_white,
        -- },
        tab_bar = {
            background = palette.base,
            active_tab = active_tab,
            inactive_tab = inactive_tab,
            inactive_tab_hover = active_tab,
            new_tab = inactive_tab,
            new_tab_hover = active_tab,
        }
    }
end

-- Configuration

local wezterm = require "wezterm"

return {
    front_end = "WebGpu",
    default_prog = {
        "/opt/homebrew/bin/nu",
        "-l"
    },
    freetype_render_target = "HorizontalLcd",
    font = wezterm.font_with_fallback {
        { family = "Iosevka Custom" },
        { family = "Symbols Nerd Font Mono", scale = 0.5 },
    },
    bold_brightens_ansi_colors = "No",
    allow_square_glyphs_to_overflow_width = "Never",
    font_size = 15,
    initial_cols = 120,
    initial_rows = 60,
    window_padding = {
        left = "0.5cell",
        right = "0.5cell",
        top = "0.5cell",
        bottom = "0.5cell",
    },
    use_fancy_tab_bar = false,
    enable_tab_bar = false,
    native_macos_fullscreen_mode = true,
    window_close_confirmation = "NeverPrompt",
    colors = colors(),
    keys = {
        {
            mods = 'CMD|SHIFT',
            key = 't',
            action = wezterm.action_callback(function(window, pane)
                local mux = window:mux_window()
                local url = pane:get_current_working_dir()
                local new_tab, new_pane, new_window = mux:spawn_tab {
                    cwd = wezterm.home_dir
                }
                new_pane:split { size = 37 }
                new_pane:split {
                    size = 110,
                    cwd = url.file_path
                }
            end),
        },
    },
}
