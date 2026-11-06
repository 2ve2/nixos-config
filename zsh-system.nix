# Zsh as the login shell (from yzua's host config).
{ pkgs, ... }:
{
  programs.zsh.enable = true;
  # Lets Zsh find completions installed by packages.
  environment.pathsToLink = [ "/share/zsh" ];
  users.users.lord2ve.shell = pkgs.zsh;
}
