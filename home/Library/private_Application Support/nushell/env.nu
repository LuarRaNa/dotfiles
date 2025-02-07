# Nushell Environment Config File
$env.STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

$env.TRANSIENT_PROMPT_COMMAND = ""
$env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| [(ansi defb) "I:" (ansi reset) (char space)] | str join}
$env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| [(ansi defb) "N:" (ansi reset) (char space)] | str join}
$env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| [(ansi defb) "-:" (ansi reset) (char space)] | str join}
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = {|| "" }
$env.PROMPT_INDICATOR = {|| "" }
$env.PROMPT_INDICATOR_VI_INSERT = {|| [(ansi defb) "I:" (ansi reset) (char space)] | str join}
$env.PROMPT_INDICATOR_VI_NORMAL = {|| [(ansi defb) "N:" (ansi reset) (char space)] | str join}
$env.PROMPT_MULTILINE_INDICATOR = {|| [(ansi defb) "-:" (ansi reset) (char space)] | str join}

$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand -n }
        to_string: { |v| $v | path expand -n | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand -n }
        to_string: { |v| $v | path expand -n | str join (char esep) }
    }
}

$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

$env.HOMEBREW_CELLAR = '/opt/homebrew/Cellar'
$env.HOMEBREW_PREFIX = '/opt/homebrew'
$env.HOMEBREW_REPOSITORY = '/opt/homebrew'
$env.INFOPATH = '/opt/homebrew/share/info:'
$env.MANPATH = '/opt/homebrew/share/man::'
$env.HOMEBREW_BIN = '/opt/homebrew/bin'
$env.HOMEBREW_SBIN = '/opt/homebrew/sbin'
$env.EDITOR = ([$env.HOMEBREW_BIN, '/nvim'] | str join)
$env.LIBGL_ALWAYS_SOFTWARE = 'true'

$env.LOCAL_BIN = ([$env.HOME, '/.local/bin'] | str join)
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.LOCAL_BIN)
$env.PATH = ($env.PATH | split row (char esep) | prepend '/usr/local/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.HOMEBREW_BIN)
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.HOMEBREW_SBIN)
