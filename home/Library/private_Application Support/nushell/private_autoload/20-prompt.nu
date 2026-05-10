# Prompt behavior that complements vendor/autoload/oh-my-posh.nu.

def prompt_mode_indicator [mode: string] {
    [(char space) "[" $mode "]" (char newline)] | str join
}

# oh-my-posh owns PROMPT_COMMAND. Nushell's native vi indicators are dynamic, so
# they provide the mode marker while keeping the editable command line empty.
$env.POSH_VI_MODE = ""
$env.PROMPT_INDICATOR = {|| prompt_mode_indicator "I" }
$env.PROMPT_INDICATOR_VI_INSERT = {|| prompt_mode_indicator "I" }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| prompt_mode_indicator "N" }
$env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
$env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
$env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
$env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
