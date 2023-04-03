# Nushell Environment Config File

def create_left_prompt [] {
    let is_home_in_path = ($env.PWD | str starts-with $nu.home-path)

    let path_segment = if ($is_home_in_path) {
        [
            (char space)
            (char space)
            ($env.PWD | str replace $nu.home-path (char -u "EB06"))
            (char space)
            (char space)
        ] | str join
    } else {
        [
            (char space)
            (char space)
            ($env.PWD)
            (char space)
            (char space)
        ] | str join
    }

    let shell = if (is-admin) {
        "ROOT"
    } else {
        "USER"
    }

    let status = if ($env.LAST_EXIT_CODE != 0) {
        (char -u "F00D")
    } else {
        (char -u "F00C")
    }

    let prompt = ([
        # SHELL
        (ansi reset)
        (ansi cr)
        (char space)
        (char space)
        (char -u "F2C0")
        (char space)
        (char space)
        ($shell)
        (char space)
        (char space)
        # PATH
        (ansi reset)
        (ansi wr)
        ($path_segment)
        # NEW_LINE
        (ansi reset)
        (char enter)
        (char space)
        (char space)
        (char -u "F061")
        (ansi reset)
    ] | str join)

    $prompt
}

def pad_to_2_digits [number] {
    $number | into string | fill -a l -c '0' -w 2
}

def convert_ms_to_time [] {
    let ms = ($env.CMD_DURATION_MS | into int)
    let seconds = (($ms / 1000) | math floor)
    let minutes = (($seconds / 60) | math floor)
    let hours = (($minutes / 60) | math floor)

    let $ms = ($ms mod 1000)
    let $seconds = ($seconds mod 60)
    let $minutes = ($minutes mod 60)

    let hh_mm_ss = ([
        (pad_to_2_digits $hours)
        (":")
        (pad_to_2_digits $minutes)
        (":")
        (pad_to_2_digits $seconds)
        (":")
        (pad_to_2_digits $ms)
    ] | str join)

    $hh_mm_ss
}

def create_right_prompt [] {
    let time_segment = ([
        (ansi reset)
        (ansi ur)
        (char space)
        (char space)
        (char -u "F0150")
        (char space)
        (char space)
        (convert_ms_to_time)
        (char space)
        (char space)
    ] | str join)

    $time_segment
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = { " " }
let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = { "〉" }
let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

let-env HOMEBREW_CELLAR = '/opt/homebrew/Cellar'
let-env HOMEBREW_PREFIX = '/opt/homebrew'
let-env HOMEBREW_REPOSITORY = '/opt/homebrew'
let-env INFOPATH = '/opt/homebrew/share/info:'
let-env MANPATH = '/opt/homebrew/share/man::'
let-env HOMEBREW_BIN = '/opt/homebrew/bin'
let-env HOMEBREW_SBIN = '/opt/homebrew/sbin'
let-env EDITOR = ([$env.HOMEBREW_BIN, '/hx'] | str join)
let-env LIBGL_ALWAYS_SOFTWARE = 'true'

let-env LOCAL_BIN = ([$env.HOME, '/.local/bin'] | str join)

let-env PATH = ($env.PATH | split row (char esep) | prepend $env.LOCAL_BIN)

let-env PATH = ($env.PATH | split row (char esep) | prepend '/usr/local/bin')

let-env PATH = ($env.PATH | split row (char esep) | prepend $env.HOMEBREW_BIN)
let-env PATH = ($env.PATH | split row (char esep) | prepend $env.HOMEBREW_SBIN)

