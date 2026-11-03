{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.configurationLimit = 10;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  zramSwap.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    pciutils
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = true;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId  = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
