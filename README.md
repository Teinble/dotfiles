# dotfiles

Personal Linux Bash and tmux configuration, plus my macOS application manifest.

## macOS applications

`Brewfile` records my CLI tools, desktop apps, and App Store apps. It does not sync settings or sign-ins.

```bash
brew bundle --file=Brewfile
```

Review the list before installing. Existing manually installed apps can conflict with Cask installation; do not force-overwrite them.

Update this list by editing `Brewfile`, or using `brew bundle add --cask APP --file=Brewfile` and `brew bundle remove --cask APP --file=Brewfile`. Commit and push the resulting change. Avoid overwriting the curated list with `brew bundle dump --force`.

## Existing checkouts

History was sanitized before publication. Back up your untracked and machine-local files, then use a fresh clone rather than merging the old history. Keep the private `local.bash` outside Git; start from `local.example.bash` on new machines.

## Layout

```text
bash/bashrc
bash/bashrc.d/
  aliases.bash
  completion.bash
  env.bash
  history.bash
  local.example.bash
  options.bash
  paths.bash
  prompt.bash
tmux/
  tmux.conf.local
```

`bash/bashrc.d/local.bash` is ignored by git. Use it for machine-specific
settings, secrets, local paths, and cluster-specific overrides.

The tmux setup keeps using oh-my-tmux from:

```text
~/.local/share/tmux/oh-my-tmux/.tmux.conf
```

and tracks only personal overrides in `tmux/tmux.conf.local`.

`uv` is not vendored in this repo. Install it on a new machine, then Bash will
load uv and uvx completion automatically:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## Install

On a Linux x86_64 dev machine, clone this repo and run:

```bash
./install.sh
exec bash
```

This links the Bash configuration and installs pinned, checksum-verified
versions of `fzf`, `bat`, and `fd` into `~/.local/bin`; it never needs `sudo`.

To update another dev machine:

```bash
git pull --ff-only
./install.sh
exec bash
```

To update a tool version for every machine, change its version and checksum
near the top of `install.sh`, then commit that change.
