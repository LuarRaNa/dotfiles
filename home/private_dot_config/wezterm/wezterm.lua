local wezterm = require 'wezterm';

return {
  default_cursor_style = "BlinkingBlock",
  font = wezterm.font({
    family = "JetBrainsMono Nerd Font Mono",
    -- harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
  }),
  font_size = 16,
  initial_cols = 140,
  initial_rows = 40,
  -- keys = {
  --   {key="f", mods="CTRL|CMD", action="ToggleFullScreen"},
  -- }
  window_decorations = "NONE",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
