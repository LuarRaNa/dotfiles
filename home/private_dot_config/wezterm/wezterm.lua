local wezterm = require 'wezterm';

return {
  -- Cursor
  default_cursor_style = "BlinkingBlock",
  force_reverse_video_cursor = true,
  -- Font Conf
  font = wezterm.font({
    family = "JetBrainsMono Nerd Font Mono",
    -- harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
  }),
  font_size = 13,
  line_height = 1.0,
  -- Shorcuts
  keys = {
    {key="f", mods="CTRL|CMD", action="ToggleFullScreen"},
  },
  -- Window size and decorations
  color_scheme = "Gruvbox Dark",
  initial_cols = 200,
  initial_rows = 50,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  window_decorations = "NONE",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
