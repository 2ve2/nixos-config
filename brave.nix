# Brave as the main browser, with only the requested extensions.
_: {
  programs.brave = {
    enable = true;
    # Keep saved passwords in the encrypted keyring in both GNOME and Niri.
    commandLineArgs = [ "--password-store=gnome-libsecret" ];
    extensions = [
      { id = "gmegofmjomhknnokphhckolhcffdaihd"; } # JSONView
      { id = "gppongmhjkpfnbhagpmjfkannfbllamg"; } # Wappalyzer
    ];
  };
}
