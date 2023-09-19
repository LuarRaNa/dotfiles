# Nushell Config File
$env.config = {
  show_banner: false

  ls: {
    use_ls_colors: false
    clickable_links: true
  }

  rm: {
    always_trash: true
  }

  table: {
    mode: rounded
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
    vi_insert: block
    vi_normal: block
  }
}

use ~/.cache/starship/init.nu
