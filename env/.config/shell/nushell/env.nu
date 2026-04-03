# Nushell environment config
# This file is loaded before config.nu

$env.TERM = "xterm-256color"

# PATH additions
let home_bin = ($env.HOME | path join ".bin")
let home_local_bin = ($env.HOME | path join ".local" "bin")
let cargo_bin = ($env.HOME | path join ".cargo" "bin")
let go_bin = "/usr/local/go/bin"
let go_home_bin = ($env.HOME | path join "go" "bin")
let flutter_bin = ($env.HOME | path join "flutter" "bin")
let zig_bin = "/opt/zig"

let path_adds = [
    $home_bin
    $home_local_bin
    $cargo_bin
    $go_bin
    $go_home_bin
    $flutter_bin
    $zig_bin
]

for dir in $path_adds {
    if ($dir | path exists) {
        $env.PATH = ($env.PATH | split row (char esep) | prepend $dir)
    }
}

# XDG Base Directory
if ($env.XDG_CONFIG_HOME | is-empty) {
    $env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
}
if ($env.XDG_DATA_HOME | is-empty) {
    $env.XDG_DATA_HOME = ($env.HOME | path join ".local" "share")
}
if ($env.XDG_CACHE_HOME | is-empty) {
    $env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")
}

# Editors
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

# Cargo
$env.CARGO_HOME = ($env.HOME | path join ".cargo")
$env.RUSTUP_HOME = ($env.HOME | path join ".rustup")

# Bun
$BUN_INSTALL = ($env.HOME | path join ".bun")
if ($BUN_INSTALL | path exists) {
    $env.PATH = ($env.PATH | split row (char esep) | prepend ($BUN_INSTALL | path join "bin"))
}

# Android
let android_home = ($env.HOME | path join "Android" "Sdk")
if ($android_home | path exists) {
    $env.ANDROID_HOME = $android_home
    $env.PATH = ($env.PATH | split row (char esep) | append ($android_home | path join "emulator"))
    $env.PATH = ($env.PATH | split row (char esep) | append ($android_home | path join "platform-tools"))
}

# Wayland
$env.YDOTOOL_SOCKET = "/tmp/.ydotool_socket"
