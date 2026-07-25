{ config, pkgs, ... }:

{
  programs.plasma = {
    enable = true;

    workspace = {
      # Thème global (Look and Feel) - WhiteSur (style macOS Big Sur, variante claire)
      lookAndFeel = "com.github.vinceliuice.WhiteSur";
      # Schéma de couleurs
      colorScheme = "WhiteSur";
      # Thème d'icônes (assorti à WhiteSur)
      iconTheme = "WhiteSur";
      # Style des widgets (Application Style)
      widgetStyle = "Breeze";
    };
  };

  # Disposition de bureau reproduisant le layout officiel du thème WhiteSur
  # (source: plasma/look-and-feel/com.github.vinceliuice.WhiteSur/contents/layouts/org.kde.plasma.desktop-layout.js
  #  — layout identique entre les variantes claire et sombre)
  programs.plasma.panels = [
    # Barre du haut : menu global façon macOS
    {
      location = "top";
      height = 30; # équivalent de 2 * floor(gridUnit * 2.5 / 2) pour une gridUnit standard
      widgets = [
        "org.kde.plasma.kickoff"
        "org.kde.plasma.appmenu"
        "org.kde.plasma.panelspacer"
        "org.kde.plasma.marginsseparator"
        "org.kde.plasma.systemtray"
        "org.kde.plasma.marginsseparator"
        "org.kde.plasma.digitalclock"
        "org.kde.plasma.showdesktop"
      ];
    }
    # Barre du bas : dock façon macOS, auto-hide
    {
      location = "bottom";
      height = 64;
      hiding = "dodgewindows";
      widgets = [
        {
          iconTasks = {
            launchers = [
              "preferred://filemanager"
              "preferred://browser"
              "applications:org.kde.konsole.desktop"
              "applications:systemsettings.desktop"
            ];
          };
        }
      ];
    }
  ];
}
