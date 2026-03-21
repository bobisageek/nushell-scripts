if (which carapace | is-not-empty) {
  $env.CARAPACE_BRIDGES = 'bash' # optional
  mkdir $"($nu.cache-dir)"
  carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"
}

if (which broot | is-not-empty) {
  mkdir $"($nu.cache-dir)"
  broot --print-shell-function nushell | save --force $"($nu.cache-dir)/broot-cmd.nu"
}

