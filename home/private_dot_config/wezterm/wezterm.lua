local wezterm = require 'wezterm';

return {
  default_prog = { '/opt/homebrew/bin/nu', '-l' },
  -- Cursor
  force_reverse_video_cursor = true,
  -- Font Conf
  font = wezterm.font({
    family = "JetBrainsMono Nerd Font Mono",
  }),
  font_size = 13,
  line_height = 1.0,
  freetype_load_target = 'Light',
  -- Shorcuts
  keys = {
    {key="f", mods="CTRL|CMD", action=wezterm.action.ToggleFullScreen},
  },
  -- Window size and decorations
  color_scheme = "tokyonight-storm",
  initial_cols = 200,
  initial_rows = 50,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  native_macos_fullscreen_mode = true,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
