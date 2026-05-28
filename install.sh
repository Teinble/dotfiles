#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sfn "$repo_dir/bash/bashrc" "$HOME/.bashrc"
ln -sfn "$repo_dir/bash/bashrc.d" "$HOME/.bashrc.d"

mkdir -p "$HOME/.config/tmux"

if [ -r "$HOME/.local/share/tmux/oh-my-tmux/.tmux.conf" ]; then
    ln -sfn "$HOME/.local/share/tmux/oh-my-tmux/.tmux.conf" "$HOME/.config/tmux/tmux.conf"
else
    printf 'oh-my-tmux not found at %s\n' "$HOME/.local/share/tmux/oh-my-tmux/.tmux.conf"
    printf 'Install it before using the tmux config, or replace ~/.config/tmux/tmux.conf yourself.\n'
fi

ln -sfn "$repo_dir/tmux/tmux.conf.local" "$HOME/.config/tmux/tmux.conf.local"

if ! command -v uv >/dev/null 2>&1; then
    printf 'uv not found. Install it with: curl -LsSf https://astral.sh/uv/install.sh | sh\n'
fi

printf 'Installed bash dotfiles from %s\n' "$repo_dir"
