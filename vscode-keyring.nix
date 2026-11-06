# Store VS Code logins in the GNOME keyring in both GNOME and Niri.
{ pkgs, ... }:
{
  programs.vscode.package = pkgs.vscode.override {
    commandLineArgs = "--password-store=gnome-libsecret";
  };
}
