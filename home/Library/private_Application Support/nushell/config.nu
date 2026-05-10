# Nushell Config File
$env.config = {
  # Shell UI
  show_banner: false
  show_hints: true
  render_right_prompt_on_last_line: true

  # Editing
  edit_mode: vi
  buffer_editor: "nvim"
  cursor_shape: {
    emacs: block
    vi_insert: line
    vi_normal: block
  }

  # Built-ins
  ls: {
    use_ls_colors: false
    clickable_links: true
  }

  completions: {
    use_ls_colors: false
  }

  rm: {
    always_trash: true
  }

  # Display
  table: {
    mode: psql
    header_on_separator: true
    index_mode: always
  }

  # History
  history: {
    max_size: 100_000
    sync_on_enter: true
    file_format: "sqlite"
    isolation: true
  }

  # Tool hooks
  hooks: {
    env_change: {
      PWD: [
        {|_, _|
          if (
            (which fnm | is-not-empty)
            and (
              ('.node-version' | path exists)
              or ('.nvmrc' | path exists)
              or ('package.json' | path exists)
            )
          ) {
            fnm use --silent-if-unchanged | ignore
          }
        }
      ]
    }
  }
}
