# Extra CLI tools and shell shortcuts; Zsh reuses these Bash aliases.
{ pkgs, ... }:
{
  home.packages = [
    pkgs.nmap
    pkgs.fx
    pkgs.htmlq
    pkgs.sd
    pkgs.ast-grep
    pkgs.imagemagick
    pkgs.microfetch
  ];

  programs.bash.shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    # Opt-in full-access launches; plain CLI names remain available for subcommands.
    cx = "codex --yolo";
    hd = "herdr";
    j = "just";
    ll = "ls -lah";
    oc = "opencode --auto";
    open = "xdg-open";
  };
}
