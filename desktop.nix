{ pkgs, ... }:

{
  # Fonts: Arabic, coding, emoji and terminal icons
  fonts.packages = with pkgs; [
    amiri
    noto-fonts
    noto-fonts-color-emoji
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];

  # Fallback order so Arabic text and emoji always render properly
  fonts.fontconfig.defaultFonts = {
    sansSerif = [
      "Noto Sans"
      "Noto Sans Arabic"
    ];
    serif = [
      "Noto Serif"
      "Amiri"
    ];
    monospace = [
      "JetBrains Mono"
      "Noto Sans Mono"
    ];
    emoji = [ "Noto Color Emoji" ];
  };

  # Required for tray icons (AppIndicator) to work in GNOME
  services.udev.packages = [ pkgs.gnome-settings-daemon ];
}
