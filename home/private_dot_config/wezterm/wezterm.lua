local wezterm = require 'wezterm';

return {
  front_end = "WebGpu",
  default_prog = {
    '/opt/homebrew/bin/nu',
    '-l'
  },
  -- Font Conf
  freetype_render_target = "HorizontalLcd",
  font = wezterm.font_with_fallback {
    {
      family = "JetBrainsMono Nerd Font Mono",
      harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    }
  },
  font_size = 14,
  -- Shorcuts
  keys = {
    {
      key = "f",
      mods = "CTRL|CMD",
      action = wezterm.action.ToggleFullScreen
    },
  },
  -- Window
  cell_width = 0.9,
  initial_cols = 120,
  initial_rows = 50,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = true,
  enable_tab_bar = false,
  native_macos_fullscreen_mode = true,
  window_close_confirmation = 'NeverPrompt',
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  colors = {
    -- Rose Pine theme
    foreground = "#575279",
    background = "#faf4ed",
    cursor_fg = "#575279",
    cursor_bg = "#cecacd",
    selection_fg = "#dfdad9",
    selection_bg = "#575279",
    brights = {
      "#9893a5",
      "#b4637a",
      "#286983",
      "#ea9d34",
      "#56949f",
      "#907aa9",
      "#d7827e",
      "#575279",
    },
    ansi = {
      "#f2e9e1",
      "#b4637a",
      "#286983",
      "#ea9d34",
      "#56949f",
      "#907aa9",
      "#d7827e",
      "#575279",
    },
    tab_bar = {
      background = "#faf4ed",
      active_tab = {
        bg_color = "#faf4ed",
        fg_color = "#575279",
      },
      inactive_tab = {
        bg_color = "#faf4ed",
        fg_color = "#9893a5",
      },
      inactive_tab_hover = {
        bg_color = "#faf4ed",
        fg_color = "#575279",
      },
      new_tab = {
        bg_color = "#faf4ed",
        fg_color = "#9893a5",
      },
      new_tab_hover = {
        bg_color = "#faf4ed",
        fg_color = "#575279",
      },
      inactive_tab_edge = "#9893a5",
    },
  },
}
