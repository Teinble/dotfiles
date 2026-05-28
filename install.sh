#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sfn "$repo_dir/bash/bashrc" "$HOME/.bashrc"
ln -sfn "$repo_dir/bash/bashrc.d" "$HOME/.bashrc.d"

printf 'Installed bash dotfiles from %s\n' "$repo_dir"
