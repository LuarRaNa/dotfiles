# Nushell Config File
$env.config = {
  show_banner: false
  edit_mode: vi

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

  table: {
    mode: psql
    header_on_separator: true
    index_mode: always
  }

  history: {
    max_size: 100_000
    sync_on_enter: true
    file_format: "sqlite"
    isolation: true
  }

  cursor_shape: {
    emacs: block
    vi_insert: line
    vi_normal: block
  }
}

