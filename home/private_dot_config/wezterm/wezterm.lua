-- Theme Configuration
-- One Dark, from Zed Colors
local one_dark = {
    base = 'rgba(47, 52, 62, 1)',
    surface = 'rgba(47, 52, 62, 1)',
    overlay = 'rgba(40, 44, 51, 1)',
    muted = 'rgba(169, 175, 188, 1)',
    subtle = 'rgba(135, 138, 152, 1)',
    text = 'rgba(220, 224, 229, 1)',
    -- Zed Colors
    background = 'rgba(40, 44, 51, 1)',
    black = 'rgba(40, 44, 51, 1)',
    blue = 'rgba(116, 173, 232, 1)',
    bright_black = 'rgba(82, 85, 97, 1)',
    bright_blue = 'rgba(56, 83, 120, 1)',
    bright_cyan = 'rgba(58, 86, 91, 1)',
    bright_foreground = 'rgba(220, 224, 229, 1)',
    bright_green = 'rgba(77, 97, 64, 1)',
    bright_magenta = 'rgba(94, 43, 38, 1)',
    bright_red = 'rgba(103, 58, 60, 1)',
    bright_white = 'rgba(220, 224, 229, 1)',
    bright_yellow = 'rgba(120, 100, 65, 1)',
    cyan = 'rgba(110, 180, 191, 1)',
    dim_black = 'rgba(220, 224, 229, 1)',
    dim_blue = 'rgba(190, 213, 244, 1)',
    dim_cyan = 'rgba(185, 217, 223, 1)',
    dim_foreground = 'rgba(40, 44, 51, 1)',
    dim_green = 'rgba(209, 224, 191, 1)',
    dim_magenta = 'rgba(230, 167, 158, 1)',
    dim_red = 'rgba(234, 183, 185, 1)',
    dim_white = 'rgba(87, 93, 101, 1)',
    dim_yellow = 'rgba(241, 223, 193, 1)',
    foreground = 'rgba(220, 224, 229, 1)',
    green = 'rgba(161, 193, 129, 1)',
    magenta = 'rgba(190, 80, 70, 1)',
    red = 'rgba(208, 114, 119, 1)',
    white = 'rgba(220, 224, 229, 1)',
    yellow = 'rgba(222, 193, 132, 1)'
}

-- One Light, from Zed Colors
local one_light = {
    base = 'rgba(235, 235, 236, 1)',
    surface = 'rgba(235, 235, 236, 1)',
    overlay = 'rgba(250, 250, 250, 1)',
    muted = 'rgba(88, 88, 90, 1)',
    subtle = 'rgba(126, 128, 134, 1)',
    text = 'rgba(36, 37, 41, 1)',
    -- Zed Colors
    background = 'rgba(250,250,250,1)',
    black = 'rgba(250,250,250,1)',
    blue = 'rgba(92, 120, 226, 1)',
    bright_black = 'rgba(170,170,170,1)',
    bright_blue = 'rgba(181, 186, 242, 1)',
    bright_cyan = 'rgba(163, 190, 218, 1)',
    bright_foreground = 'rgba(36, 37, 41, 1)',
    bright_green = 'rgba(178, 207, 169, 1)',
    bright_magenta = 'rgba(206, 166, 211, 1)',
    bright_red = 'rgba(240, 176, 164, 1)',
    bright_white = 'rgba(36, 37, 41, 1)',
    bright_yellow = 'rgba(241, 223, 193, 1)',
    cyan = 'rgba(58, 130, 183, 1)',
    dim_black = 'rgba(36, 37, 41, 1)',
    dim_blue = 'rgba(45, 61, 117, 1)',
    dim_cyan = 'rgba(37, 64, 88, 1)',
    dim_foreground = 'rgba(250,250,250,1)',
    dim_green = 'rgba(53, 77, 46, 1)',
    dim_magenta = 'rgba(75, 42, 80, 1)',
    dim_red = 'rgba(111, 49, 42, 1)',
    dim_white = 'rgba(151, 151, 154, 1)',
    dim_yellow = 'rgba(120, 100, 65, 1)',
    foreground = 'rgba(36, 37, 41, 1)',
    green = 'rgba(102, 159, 89, 1)',
    magenta = 'rgba(152, 78, 165, 1)',
    red = 'rgba(211, 97, 81, 1)',
    white = 'rgba(36, 37, 41, 1)',
    yellow = 'rgba(222, 193, 132, 1)'
}

local function colors(palette)
    local active_tab = {
        bg_color = palette.overlay,
        fg_color = palette.text,
    }

    local inactive_tab = {
        bg_color = palette.base,
        fg_color = palette.muted,
    }

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

local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Light'
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return one_dark
  else
    return one_light
  end
end

return {
    front_end = "WebGpu",
    default_prog = {
        "/opt/homebrew/bin/nu",
        "-l"
    },
    freetype_render_target = "HorizontalLcd",
    font = wezterm.font_with_fallback {
        { family = "Sudo" }
    },
    bold_brightens_ansi_colors = "No",
    allow_square_glyphs_to_overflow_width = "Never",
    custom_block_glyphs = false,
    font_size = 16,
    initial_cols = 150,
    initial_rows = 50,
    window_padding = {
        left = "0cell",
        right = "0cell",
        top = "0cell",
        bottom = "0cell",
    },
    use_fancy_tab_bar = false,
    enable_tab_bar = false,
    native_macos_fullscreen_mode = true,
    window_close_confirmation = "NeverPrompt",
    colors = colors(scheme_for_appearance(get_appearance())),
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
