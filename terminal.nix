{ pkgs, ... }:

{
  # Smart prompt: folder, git branch, project versions, command duration
  programs.starship.enable = true;

  # Jump to frequent folders with "z name"
  programs.zoxide.enable = true;

  # Searchable shell history on Ctrl+R (up arrow keeps its normal behavior)
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      auto_sync = false;
      update_check = false;
      style = "compact";
    };
  };

  # Fuzzy finder: Ctrl+T for files, Alt+C for folders
  programs.fzf.enable = true;

  # Auto-load project environments when entering a folder
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Modern replacements for common commands
  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.ripgrep.enable = true;
  programs.fd.enable = true;
  programs.jq.enable = true;

  # Git in a terminal UI
  programs.lazygit.enable = true;

  home.packages = with pkgs; [
    yq-go
    tree
    tokei
  ];
}
