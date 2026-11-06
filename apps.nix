{ pkgs, ... }:

{
  # Open web links with Brave
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "brave-browser.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
    };
  };

  home.packages = with pkgs; [
    google-chrome
    telegram-desktop
    vesktop
    sqlitebrowser
    postman
    obs-studio
  ];
}
