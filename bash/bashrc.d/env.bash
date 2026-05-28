# Make less more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Colored GCC warnings and errors.
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Change Slurm squeue format
export SQUEUE_FORMAT="%.18i %.9P %.50j %.8u %.2t %.10M %.6D %R"