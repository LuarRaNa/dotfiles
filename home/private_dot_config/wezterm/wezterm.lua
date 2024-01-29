local wezterm = require "wezterm"

return {
    front_end = "WebGpu",
    default_prog = {
        "/opt/homebrew/bin/nu",
        "-l"
    },
    freetype_render_target = "HorizontalLcd",
    font = wezterm.font_with_fallback {
        { family = "Iosevka Fixed" },
        { family = "Symbols Nerd Font Mono", scale = 0.6 },
    },
    font_size = 13,
    initial_cols = 186,
    initial_rows = 54,
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
    color_scheme = 'AdventureTime',
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
                new_pane:split { size = 41 }
                new_pane:split {
                    size = 100,
                    cwd = url.file_path
                }
            end),
        },
    },
}

