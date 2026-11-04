{ pkgs, ... }:

{
  # Steam with Proton-GE, GameMode and MangoHud
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.gamemode.enable = true;

  environment.systemPackages = [ pkgs.mangohud ];
}
