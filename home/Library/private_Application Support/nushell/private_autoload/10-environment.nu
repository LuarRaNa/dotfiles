# Core environment shared by interactive Nushell sessions.

def --env prepend_paths [paths: list<string>] {
    let current_path = ((
        if (($env.PATH | describe) =~ '^list') {
            $env.PATH
        } else {
            $env.PATH | split row (char esep)
        }
    ) | each { |entry| $entry | path expand -n })

    let expanded_paths = ($paths | each { |entry| $entry | path expand -n })
    $env.PATH = ($expanded_paths | append $current_path | flatten | uniq)
}

def --env setup_fnm [] {
    if (which fnm | is-empty) {
        return
    }

    let fnm_env = (fnm env --json | complete)

    if $fnm_env.exit_code == 0 {
        $fnm_env.stdout | from json | load-env
        prepend_paths [($env.FNM_MULTISHELL_PATH | path join 'bin')]
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
$env.EDITOR = 'nvim'
$env.LIBGL_ALWAYS_SOFTWARE = 'true'

$env.LOCAL_BIN = ([$env.HOME, '/.local/bin'] | str join)
prepend_paths [
    $env.LOCAL_BIN
    $env.HOMEBREW_BIN
    $env.HOMEBREW_SBIN
    '/usr/local/bin'
]

setup_fnm
