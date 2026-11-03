{ config, pkgs, lib, ... }:

{
  home.username = "lord2ve";
  home.homeDirectory = "/home/lord2ve";
  home.stateVersion = "26.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "nixos-rebuild switch --sudo --flake /home/lord2ve/nixos-config#nixos";
      update  = "nix flake update --flake /home/lord2ve/nixos-config";
      nixconf = "cd /home/lord2ve/nixos-config";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "2ve2";
      user.email = "bdalrhmnmtwq53@gmail.com";
      init.defaultBranch = "main";
    };
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "https";
  };

  # Keyboard layouts: English + Arabic (switch with Super+Space)
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.hm.gvariant.mkTuple [ "xkb" "us" ])
        (lib.hm.gvariant.mkTuple [ "xkb" "ara" ])
      ];
    };
  };
}
