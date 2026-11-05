{ config, pkgs, lib, ... }:

{
  home.username = "lord2ve";
  home.homeDirectory = "/home/lord2ve";
  home.stateVersion = "26.05";

  imports = [ ./terminal.nix ./dev.nix ./apps.nix ./ai.nix ./chrome-devtools ./git.nix ./cursor.nix ];

  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "nixos-rebuild switch --sudo --flake /home/lord2ve/nixos-config#nixos";
      update  = "nix flake update --flake /home/lord2ve/nixos-config";
      nixconf = "cd /home/lord2ve/nixos-config";
    };
  };


  programs.gh = {
    enable = true;
    settings.git_protocol = "https";
  };

  # GNOME Tweaks and the AppIndicator extension (tray icons)
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.appindicator
  ];

  dconf.settings = {
    # Keyboard layouts: English + Arabic (switch with Super+Space)
    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.hm.gvariant.mkTuple [ "xkb" "us" ])
        (lib.hm.gvariant.mkTuple [ "xkb" "ara" ])
      ];
    };

    # Enable the AppIndicator extension
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [ pkgs.gnomeExtensions.appindicator.extensionUuid ];
    };

    # Use JetBrains Mono (with icons) in the terminal and code views
    "org/gnome/desktop/interface" = {
      monospace-font-name = "JetBrainsMono Nerd Font 11";
    };
  };
}
