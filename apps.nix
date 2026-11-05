{ pkgs, ... }:

let
  # Download link for the latest version of a Firefox add-on
  amo = slug: "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
in
{
  # Firefox with separate Personal and Work profiles
  programs.firefox = {
    enable = true;

    # Lets the KeePassXC extension talk to the KeePassXC app
    nativeMessagingHosts = [ pkgs.keepassxc ];

    # Add-ons installed automatically in every profile
    policies.ExtensionSettings = {
      "uBlock0@raymondhill.net" = {
        install_url = amo "ublock-origin";
        installation_mode = "force_installed";
      };
      "addon@darkreader.org" = {
        install_url = amo "darkreader";
        installation_mode = "force_installed";
      };
      "jsonview@brh.numbera.com" = {
        install_url = amo "jsonview";
        installation_mode = "force_installed";
      };
      "wappalyzer@crunchlabz.com" = {
        install_url = amo "wappalyzer";
        installation_mode = "force_installed";
      };
      "addon@simplelogin" = {
        install_url = amo "simplelogin";
        installation_mode = "force_installed";
      };
      "keepassxc-browser@keepassxc.org" = {
        install_url = amo "keepassxc-browser";
        installation_mode = "force_installed";
      };
    };

    profiles = {
      personal = {
        id = 0;
        name = "Personal";
        isDefault = true;
      };
      work = {
        id = 1;
        name = "Work";
      };
    };
  };

  # Separate launcher icon for the Work profile
  xdg.desktopEntries.firefox-work = {
    name = "Firefox (Work)";
    exec = "firefox -P Work";
    icon = "firefox";
    categories = [
      "Network"
      "WebBrowser"
    ];
  };

  # Open web links with Firefox
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };

  # Microphone and speaker effects, running in the background
  services.easyeffects.enable = true;

  home.packages = with pkgs; [
    google-chrome
    telegram-desktop
    vesktop
    keepassxc
    sqlitebrowser
    postman
  ];
}
