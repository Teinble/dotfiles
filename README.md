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
```

`bash/bashrc.d/local.bash` is ignored by git. Use it for machine-specific
settings, secrets, local paths, and cluster-specific overrides.

## Install

From the repo root:

```bash
./install.sh
```
