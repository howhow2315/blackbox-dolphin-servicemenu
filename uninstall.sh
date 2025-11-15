#!/bin/bash
set -euo pipefail


# Uninstaller

kio_dir="$HOME/.local/share/kio"
servicemenus_dir="$kio_dir/servicemenus"

# Remove files
files=("blackbox-run-file.desktop" "blackbox-open-here.desktop")
for file in "${files[@]}"; do
    filepath="$servicemenus_dir/$file"
    [[ -f "$filepath" ]] && rm "$filepath"
done

# Cleanup empty directories
for dir in "$servicemenus_dir" "$kio_dir"; do
    [[ -d "$dir" && -z "$(ls -A "$dir")" ]] && rmdir "$dir"
done
