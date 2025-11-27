# add path entries from config file if it exists

const path_file = '~/.config/path-additions.txt'
if ( $path_file | path exists) {
  export-env {
    $env.PATH ++= ($path_file | path expand | open $in | lines -s | path expand)
  }
}
