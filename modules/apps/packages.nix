{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.kate
    kdePackages.kdeconnect-kde
    netflix
    ytmdesktop
    klavaro
    whitesur-kde
    whitesur-gtk-theme
    whitesur-icon-theme
  ];
}
