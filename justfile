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

# Build the system and show what will change, without activating it.
preview:
    nvd diff /run/current-system "$(nix build .#nixosConfigurations.nixos.config.system.build.toplevel --no-link --print-out-paths)"

# Activate the configuration (same as rebuild).
switch:
    nixos-rebuild switch --sudo --flake .#nixos

# List system generations (no build or switch).
status:
    nixos-rebuild list-generations

# Format Nix files (modifies files).
fmt:
    @git ls-files -z --cached --others --exclude-standard -- '*.nix' ':(exclude)hardware-configuration.nix' ':(exclude,glob)**/hardware-configuration.nix' | \
      while IFS= read -r -d '' file; do if [ -f "$file" ]; then nixfmt "$file"; fi; done

# Read-only formatting check for Nix files.
fmt-check:
    @git ls-files -z --cached --others --exclude-standard -- '*.nix' ':(exclude)hardware-configuration.nix' ':(exclude,glob)**/hardware-configuration.nix' | \
      while IFS= read -r -d '' file; do if [ -f "$file" ]; then nixfmt --check "$file"; fi; done

# Fast static analysis for Nix files.
lint:
    statix check --ignore 'hardware-configuration.nix' --ignore '**/hardware-configuration.nix' .
    @git ls-files -z --cached --others --exclude-standard -- '*.nix' ':(exclude)hardware-configuration.nix' ':(exclude,glob)**/hardware-configuration.nix' | \
      while IFS= read -r -d '' file; do if [ -f "$file" ]; then deadnix --fail -- "$file"; fi; done
