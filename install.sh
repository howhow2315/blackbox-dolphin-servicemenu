#!/bin/bash
set -euo pipefail

CMD=$(basename "$0")

# Display a message "[*] with a symbol prefix"
_notif() {
    local msg="${1:-""}" sym=${2:-"*"}
    [[ -n "$msg" ]] && echo "[$sym] $msg"
}

# Display an error message and exit with a specified code (default 1)
_err() {
    local msg="$1" code=${2:-1}
    _notif "$CMD ERROR: $msg" !
    exit "$code"
}

# Run a command silently, suppressing stdout and stderr, shell-dependent
case "$(basename "$SHELL")" in
    bash|zsh) _silently() { "$@" &> /dev/null; } ;;
    *) _silently() { "$@" > /dev/null 2>&1; } ;; # Default to POSIX-compatible syntax
esac

# Check if a command exists in PATH
_hascmd() { _silently command -v "$1"; }


# Installer

_hascmd curl || _err "'curl' is required."

repo="https://github.com/howhow2315/blackbox-dolphin-servicemenu"
kio_dir="$HOME/.local/share/kio"
servicemenus_dir="$kio_dir/servicemenus"

mkdir -p "$servicemenus_dir"

# Download files
files=("blackbox-run-file.desktop" "blackbox-open-here.desktop")
for file in "${files[@]}"; do
    filepath="$servicemenus_dir/$file"
    [[ ! -f "$filepath" ]] && _silently curl -fL "$repo/raw/main/$file" -o "$filepath"
done