# Nushell Environment Config File

def create_left_prompt [] {
    let is_home_in_path = ($env.PWD | str starts-with $nu.home-path)

    let path_segment = if ($is_home_in_path) {
        [
            (char space)
            ($env.PWD | str replace $nu.home-path '')
            (char space)
        ] | str collect
     } else {
        [
            (char space)
            ($env.PWD)
            (char space)
        ] | str collect
    }

    let shell = if (is-admin) {
        [
            (ansi { fg: "#1E1E1E" bg: "#F14C4C" attr: b })
            (char space)
            (ansi { fg: "#1E1E1E" bg: "#F14C4C" attr: b })
            ($">_ in")
            (char space)
            (ansi { fg: "#F14C4C" bg: "#1E1E1E" attr: b })
            (char -u e0b0)
        ] | str collect
    } else {
        [
            (ansi { fg: "#1E1E1E" bg: "#3B8EEA" attr: b })
            (char space)
            (ansi { fg: "#1E1E1E" bg: "#3B8EEA" attr: b })
            ($">_ in")
            (char space)
            (ansi { fg: "#3B8EEA" bg: "#1E1E1E" attr: b })
            (char -u e0b0)
        ] | str collect
    }

    let prompt = ([
        ($shell)
        (ansi { fg: '#1E1E1E' bg: '#666666' attr: b })
        (char -u e0b0)
        ($path_segment)
        (ansi { fg: '#666666' bg: '#1E1E1E' attr: b })
        (char -u e0b0)
        (ansi reset)
    ] | str collect)

    $prompt
}

def create_right_prompt [] {
    let time_segment = ([
        (ansi { fg: "#D670D6" bg: "#1E1E1E" attr: b })
        (char -u e0b2)
        (ansi { fg: "#1E1E1E" bg: "#D670D6" attr: b })
        (date now | date format '%m/%d/%Y %r')
    ] | str collect)

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
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | path expand | str collect (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | path expand | str collect (char esep) }
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

let-env PATH = ($env.PATH | prepend $env.HOMEBREW_BIN)
let-env PATH = ($env.PATH | prepend $env.HOMEBREW_SBIN)

let-env LOCAL_BIN = ([$env.HOME, '/.local/bin'] | str collect)

let-env PATH = ($env.PATH | prepend $env.LOCAL_BIN)

