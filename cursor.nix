{ config, pkgs, ... }:

{
  # Use the same crisp pointer in Niri, GTK apps, and the GNOME fallback.
  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-light";
    size = 30;
    gtk.enable = true;
  };

  dconf.settings."org/gnome/desktop/interface" = {
    cursor-theme = config.home.pointerCursor.name;
    cursor-size = config.home.pointerCursor.size;
  };
}
