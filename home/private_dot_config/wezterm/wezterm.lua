-- Theme Configuration
-- Rose Pine Dawn, from official website

local palette = {
    base = "#faf4ed",
    surface = "#fffaf3",
    overlay = "#f2e9e1",
    muted = "#9893a5",
    subtle = "#797593",
    text = "#575279",
    love = "#b4637a",
    gold = "#ea9d34",
    rose = "#d7827e",
    pine = "#286983",
    foam = "#56949f",
    iris = "#907aa9",
    highlight_low = "#f4ede8",
    highlight_med = "#dfdad9",
    highlight_high = "#cecacd",
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
        foreground = palette.text,
        background = palette.base,
        cursor_bg = palette.muted,
        cursor_border = palette.muted,
        cursor_fg = palette.text,
        selection_bg = palette.overlay,
        selection_fg = palette.text,
        ansi = {
            palette.surface,
            palette.love,
            palette.pine,
            palette.gold,
            palette.foam,
            palette.iris,
            palette.rose,
            palette.text
        },
        brights = {
            palette.subtle,
            palette.love,
            palette.pine,
            palette.gold,
            palette.foam,
            palette.iris,
            palette.rose,
            palette.text
        },
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
    allow_square_glyphs_to_overflow_width = "Never",
    font_size = 15,
    initial_cols = 186,
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

