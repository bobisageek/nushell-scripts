if (which carapace | is-not-empty) {
  $env.CARAPACE_BRIDGES = 'bash' # optional
  mkdir $"($nu.cache-dir)"
  carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"
}
