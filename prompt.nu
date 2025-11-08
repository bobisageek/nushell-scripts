###### prompt changes

# windows logo for windows, tux for anything else
let prompt_char = if (uname | get operating-system) has "Windows" { "\u{e70f}" } else { "\u{e712}" }

$env.PROMPT_COMMAND = {||
    let dir = match (do -i { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let path_segment = $"($path_color)($dir)(ansi reset)"

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        '❌: '
        ($env.LAST_EXIT_CODE)
        (ansi reset)
        '|'
    ] | str join)
    } else { '' }

    let mem = sys mem | select available total | $'(ansi yellow)mem: ($in.available / $in.total * 100 | math floor)% free(ansi reset)|'

    let user = do {
        let uvar = [USERNAME USER] | where {|k| $k in $env }
        if ($uvar | is-not-empty) {
            $'($env | get ($uvar | first))@'
        } else {
            ''
        }
    }

    $'($last_exit_code)($mem)($user)($path_segment)(char newline)($prompt_char) '
}

$env.PROMPT_INDICATOR = '> '

$env.TRANSIENT_PROMPT_COMMAND = ''

$env.PROMPT_COMMAND_RIGHT = ''

$env.TRANSIENT_PROMPT_COMMAND_RIGHT = ''

