#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bin_dir="$HOME/.local/bin"

fzf_version=0.74.2
bat_version=0.26.1
fd_version=10.4.2

case "$(uname -s)-$(uname -m)" in
    Linux-x86_64) ;;
    *) printf 'Unsupported platform: %s-%s\n' "$(uname -s)" "$(uname -m)" >&2; exit 1 ;;
esac

for command_name in curl tar sha256sum install; do
    command -v "$command_name" >/dev/null || {
        printf 'Required command not found: %s\n' "$command_name" >&2
        exit 1
    }
done

mkdir -p "$bin_dir"

scratch_dir="${TMPDIR:-/tmp}"
if mkdir -p "$scratch_dir" 2>/dev/null && work_dir="$(mktemp -d "$scratch_dir/dotfiles-install.XXXXXX" 2>/dev/null)"; then
    :
else
    work_dir="$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-install.XXXXXX")"
fi
trap 'rm -rf "$work_dir"' EXIT

install_tar_binary() {
    name="$1"
    version="$2"
    url="$3"
    checksum="$4"
    binary_path="$5"

    if [ -x "$bin_dir/$name" ] && "$bin_dir/$name" --version 2>/dev/null | grep -Fq "$version"; then
        printf '%s %s already installed\n' "$name" "$version"
        return
    fi

    archive="$work_dir/$name.tar.gz"
    curl -fL --retry 3 "$url" -o "$archive"
    printf '%s  %s\n' "$checksum" "$archive" | sha256sum --check --status
    tar -xzf "$archive" -C "$work_dir"
    install -m 0755 "$work_dir/$binary_path" "$bin_dir/$name"
    printf 'Installed %s %s\n' "$name" "$version"
}

install_tar_binary \
    fzf "$fzf_version" \
    "https://github.com/junegunn/fzf/releases/download/v$fzf_version/fzf-$fzf_version-linux_amd64.tar.gz" \
    b3648f48675612b69ee35371cf6dc99ca96d767e89b912d079080916ac8ba8bd \
    fzf

install_tar_binary \
    bat "$bat_version" \
    "https://github.com/sharkdp/bat/releases/download/v$bat_version/bat-v$bat_version-x86_64-unknown-linux-gnu.tar.gz" \
    726f04c8f576a7fd18b7634f1bbf2f915c43494c1c0f013baa3287edb0d5a2a3 \
    "bat-v$bat_version-x86_64-unknown-linux-gnu/bat"

install_tar_binary \
    fd "$fd_version" \
    "https://github.com/sharkdp/fd/releases/download/v$fd_version/fd-v$fd_version-x86_64-unknown-linux-gnu.tar.gz" \
    def59805cd14b5651b68990855f426ad087f3b96881296d963910431ba3143c8 \
    "fd-v$fd_version-x86_64-unknown-linux-gnu/fd"

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
