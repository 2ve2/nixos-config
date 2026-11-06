# Zsh setup; aliases are shared with Bash.
{ config, lib, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = config.programs.bash.shellAliases;
    autosuggestion = {
      enable = true;
      # Midnight Ink base03.
      highlight = "fg=#808080";
    };
    syntaxHighlighting.enable = true;
    # Atuin keeps Ctrl-R; arrows search only commands matching the typed text.
    historySubstringSearch.enable = true;
    # Start tmux before loading the heavier interactive hooks in the outer shell.
    # Keep SSH, non-Ghostty shells, tmux panes, and plain terminals unattached.
    initContent = lib.mkOrder 500 ''
      if [[ -o interactive && -z ''${TMUX-} && -z ''${SSH_CONNECTION-} \
        && ''${GHOSTTY_NO_TMUX-} != 1 && ''${TERM-} == xterm-ghostty ]] \
        && command -v tmux >/dev/null 2>&1; then
        tmux new-session -A -s main
      fi

      # Use a selectable, case-insensitive completion menu without another
      # completion framework or a second compinit.
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
      zstyle ':completion:*' group-name ""
      zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
    '';
  };
}
