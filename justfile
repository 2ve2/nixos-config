set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default:
    @just --list

# Evaluate the flake without building or activating it.
verify:
    nix flake check --no-build --no-write-lock-file .

# Evaluate both configs and flag Nix files Git flakes cannot see yet.
check:
    @untracked="$(git ls-files --others --exclude-standard -- '*.nix')"; \
      if [ -n "$untracked" ]; then \
        printf 'Warning: Git flakes ignore untracked .nix files. Stage new files you want evaluated:\n%s\n' "$untracked"; \
      else \
        echo "No untracked Nix files."; \
      fi
    @just verify
