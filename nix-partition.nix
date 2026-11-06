# The Nix store lives on its own 200G partition (label "nix").
_: {
  fileSystems."/nix" = {
    device = "/dev/disk/by-label/nix";
    fsType = "ext4";
    neededForBoot = true;
    options = [ "noatime" ];
  };
}
