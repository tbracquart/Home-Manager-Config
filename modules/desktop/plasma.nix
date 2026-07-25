{ config, pkgs, ... }:

{
  programs.plasma = {
    enable = true;

    workspace = {
      # Thème global (Look and Feel)
      lookAndFeel = "Utterly-Sweet";
      # Schéma de couleurs
      colorScheme = "UtterlySweet";
      # Thème d'icônes (c'est ici qu'on le met !)
      iconTheme = "BeautySolar";
      # Style des widgets (Application Style)
      widgetStyle = "Breeze";
    };
  };
}
