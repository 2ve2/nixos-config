_:

{
  # Docker, with permission to use it without sudo
  virtualisation.docker.enable = true;
  users.users.lord2ve.extraGroups = [ "docker" ];

  # Run Electron apps (VS Code) natively on Wayland, so text is not blurry
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
