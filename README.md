# dotfiles

Personal shell configuration.

## Layout

```text
bash/bashrc
bash/bashrc.d/
  aliases.bash
  completion.bash
  conda.bash
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

From the repo root:

```bash
./install.sh
```
