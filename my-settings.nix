{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
  programs.nix-ld.enable = true;

  boot.loader.systemd-boot.configurationLimit = 10;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  zramSwap.enable = true;

  # Retry stalled downloads automatically instead of hanging
  nix.settings.connect-timeout = 10;
  nix.settings.stalled-download-timeout = 300;
  nix.settings.download-attempts = 5;

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
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
